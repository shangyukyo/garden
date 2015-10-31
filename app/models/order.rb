class Order < ActiveRecord::Base
  include AASM
  include LocaleTransform

  belongs_to :user
  has_many :order_goods
  has_many :goods, through: :order_goods
  has_many :order_payments
  has_many :payments,  through:      :order_payments

  store :ext, accessors: [:shipping, :coupon, :warehouse, :pick_up_code]


  enum status: {
    pending:               0,      # 待支付
    paid:                  1,      # 已支付
    delivering:            2,      # 配送中
    finished:              3,      # 已完成
    canceled:              -1      # 已经取消
  }

  # 状态机
  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :delivering
    state :finished
    state :canceled

    event :pay do
      transitions from: [:pending], to: :paid
      
      after do 
        process_pick_up_code
      end

    end

    event :deliver do
      transitions from: %i(paid), to: :delivering
    end

    event :finish do
      transitions from: [:delivering, :paid, :finished], to: :finished
    end

  end

  before_create :generate_order_no
  def generate_order_no
    loop do
      time          = Time.now.strftime('%Y%m%d')
      random_no     = '%010d' % SecureRandom.random_number(10000000000)
      self.order_no = time << random_no
      break if not Order.find_by(order_no: order_no)
    end    
  end

  def cover_url
    goods.first.photo_urls.first
  end

  def clone
    ActiveRecord::Base.transaction do 
      order = user.orders.build
      order.origin_total_price = origin_total_price
      order.total_price = origin_total_price
      order.quantity = quantity
      order.warehouse = warehouse
      order.save

      order.goods << goods
      order
    end
  end

  def use_coupon coupon_id      
    target_coupon  = user.coupons.find_by(id: coupon_id)
    if target_coupon.present?
                
      if not target_coupon.effect?
        raise "优惠券已过有效期或未到有效期!"
      end

      if target_coupon.fill_coupon? and self.origin_total_price < target_coupon.minimum
        raise "消费满#{target_coupon.minimum}才可使用此优惠券"
      end

      self.total_price = self.origin_total_price - target_coupon.price

      if self.total_price <= 0
        self.total_price = 0.01
      end
      
      self.coupon = target_coupon.as_json(except: [:created_at, :updated_at])
      self.save!
      self
    end    
  end

  def process_pick_up_code
    self.pick_up_code = SecureRandom.random_number(100000000).to_s.rjust(9, '0')
    self.save!
    send_pick_up_code
  end

  def send_pick_up_code
    begin
      if self.warehouse.present?
        address = self.warehouse["address"]
        time = self.warehouse["business_time"].scan(/\((.*?)\)/).map{|c| c}.join("")

        if not time.present?
          time = self.warehouse["business_time"].scan(/\（(.*?)\）/).map{|c| c}.join("")          
        end

        time = Time.now.tomorrow.strftime("%F") + " " + time
      else
        address, time = "", ""
      end

      s = Sms::Base.new to: self.user.mobile, code: self.pick_up_code, address: address, time: time, type: 'pick_up_code'
      s.send    
    rescue => e
      nil    
    end
  end

  def test_regext
    puts self.warehouse["business_time"].scan(/\（(.*?)\）/).map{|c| c}.join("")
  end

end
