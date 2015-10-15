class Payment < ActiveRecord::Base
  self.primary_key = 'payment_no'
  
  include AASM
  
  validates_numericality_of :original_amount
  validates_presence_of     :original_amount

  belongs_to  :user
  has_many    :order_payments, foreign_key:  :payment_no
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
        orders.map { |order|           
          order.try(:pay!) 

          if order.coupon.present?
            order.user.use_coupon(order.coupon["id"])
          end
        }        
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


  def alipay_mobile_securitypay

    Alipay::Mobile::Service.mobile_securitypay_pay_string({
      seller_id: 'dashengtianqi@aliyun.com',
      out_trade_no: payment_no,
      notify_url: 'http://101.200.197.162/api/notify/alipay',
      subject: subject,
      # total_fee: original_amount,
      total_fee: 0.01,
      body: subject
    }, {
      sign_type: 'RSA',
      key: Alipay.key
    })

  end

  def wechat_mobile_securitypay
    unifiedorder_params = {
      body: subject,
      out_trade_no: payment_no,
      # total_fee: original_amount,
      total_fee: 1,
      spbill_create_ip: '101.200.197.162',
      notify_url: 'http://101.200.197.162/api/notify/wechat',
      trade_type: 'APP'      
    }

    invoke_r = WxPay::Service.invoke_unifiedorder unifiedorder_params

    puts invoke_r.inspect

    raise '支付失败' if not invoke_r.success?

    app_pay_params = {
      prepayid: invoke_r["prepay_id"],
      noncestr: invoke_r["nonce_str"]
    }

    g_r = WxPay::Service::generate_app_pay_req app_pay_params

    puts g_r.inspect
  end

end
