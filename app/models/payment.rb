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


  def alipay_mobile_securitypay

    rsa_private_key = "-----BEGIN RSA PRIVATE KEY-----
MIICXgIBAAKBgQDMJ8rJdkVelkqVx9upyW+rbNA7y4YNtQ9wNkSW/zxYCAvJ2UIE
ToTLhWmSxCkylTxxJsSUVDdyM1rKIC1HFRxbyL4brUeMvmmh9L73I6/j5By7lut7
+83qC9dUic6W47vP9ZCKw0VCp9W7XyjAOmkLP8QAGsXhRoU/pFncTdaXUQIDAQAB
AoGBAKwsKuM4cUxR51jmEiTgkuK5g+vJuqY4umph+fp2CogbUQXLydcj+O5C90Ql
VrEoFq8+iK6nT5NqJ/kqpcS60ww7SZwlUetMjpdhoH7+eMqxPSzhZDZftZyrVgts
BSu8NOZufajO3q55GvP4WDTaMMH2tr924hemKRaon/wqXbABAkEA6k8tnzWMFKNk
OEWfgOsqGjyK1ZHxJI0e/pujDN5qOkBBDSHi2j8CcaDT/0nUkHZb60Y68WCDDQsi
0suNf3rI0QJBAN8OAd/yTLS71qGVEMFivTTq3JCeO68AtKqZpDHHnDel/e0JLR5b
f2ZckMzNAinQwsR+jobP8+ejiSFNqaS6hoECQHgOUeX93eTFQ5jBs9Suqkf/NXPw
74o29OaogIcbf3qRacN81WvWVT47leR8w/mxa6/FsHX1abDJP/Kaccob88ECQQDD
v50xlYhvi/D9+L2tmSOGzx4l5Fdoa2wh05fe/9g+lfPUE5t+6rlRcaa5tKhTXhuv
KYmXEeRwwnnTuj5IjFEBAkEAuSFDB9a9WdUVQtV9m34yP6JzYMagkK/F2xSoOj6T
f2cQYwcFL9I0sSusTV37/87S/7QMmhBB7R6ftuxIwuaZbQ==
-----END RSA PRIVATE KEY-----"


    Alipay::Mobile::Service.mobile_securitypay_pay_string({
      out_trade_no: '20150401000-0001',
      notify_url: 'http://101.200.197.162/api/notify/alipay',
      subject: 'subject',
      total_fee: '0.01',
      body: 'test'
    }, {
      sign_type: 'RSA',
      key: rsa_private_key
    })

  

  end

end
