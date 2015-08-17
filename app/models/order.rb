class Order < ActiveRecord::Base
  include AASM
  include LocaleTransform

  belongs_to :user
  has_many :order_goods
  has_many :goods, through: :order_goods

  store :ext, accessors: [:shipping, :coupon]


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
    state :canceled

    event :pay do
      transitions from: [:pending], to: :paid
      
    end

    event :deliver do
      transitions from: %i(paid), to: :delivering
    end

    event :finish do
      transitions from: :delivering, to: :finished
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

end
