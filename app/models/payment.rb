class Payment < ActiveRecord::Base
  self.primary_key = 'payment_no'
  
  include AASM
  
  validates_numericality_of :original_amount
  validates_presence_of     :original_amount

  belongs_to  :user
  has_many    :order_payments
  has_many    :orders,             through:      :order_payments

  # 支付的渠道
  enum gateway: {
    alipay:           0,      # 支付宝    
    wechat:           1      # 微信    
  }

  enum status: {
    pending:         0,      # 等待付款
    paid:            1,      # 已支付
    paid_failed:    -1      # 支付异常    
  }

  aasm column: :status, enum: true do
    state :pending, initial: true
    state :paid
    state :paid_failed

    event :purchase do
      transitions from: [:pending, :paid_failed], to: :paid
      after do
        orders.map { |order| order.try(:pay!) }        
      end
    end

  end  

  before_create :generate_payment_no
  def generate_payment_no
    loop do
      time          = Time.now.strftime('%Y%m%d')
      random_no     = '%010d' % SecureRandom.random_number(10000000000)
      self.payment_no = time << random_no
      break if not Payment.find_by(payment_no: payment_no)
    end
  end  

end
