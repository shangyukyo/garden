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
MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMwnysl2RV6WSpXH
26nJb6ts0DvLhg21D3A2RJb/PFgIC8nZQgROhMuFaZLEKTKVPHEmxJRUN3IzWsog
LUcVHFvIvhutR4y+aaH0vvcjr+PkHLuW63v7zeoL11SJzpbju8/1kIrDRUKn1btf
KMA6aQs/xAAaxeFGhT+kWdxN1pdRAgMBAAECgYEArCwq4zhxTFHnWOYSJOCS4rmD
68m6pji6amH5+nYKiBtRBcvJ1yP47kL3RCVWsSgWrz6IrqdPk2on+SqlxLrTDDtJ
nCVR60yOl2Ggfv54yrE9LOFkNl+1nKtWC2wFK7w05m59qM7ernka8/hYNNowwfa2
v3biF6YpFqif/CpdsAECQQDqTy2fNYwUo2Q4RZ+A6yoaPIrVkfEkjR7+m6MM3mo6
QEENIeLaPwJxoNP/SdSQdlvrRjrxYIMNCyLSy41/esjRAkEA3w4B3/JMtLvWoZUQ
wWK9NOrckJ47rwC0qpmkMcecN6X97QktHlt/ZlyQzM0CKdDCxH6Ohs/z56OJIU2p
pLqGgQJAeA5R5f3d5MVDmMGz1K6qR/81c/Dvijb05qiAhxt/epFpw3zVa9ZVPjuV
5HzD+bFrr8WwdfVpsMk/8ppxyhvzwQJBAMO/nTGViG+L8P34va2ZI4bPHiXkV2hr
bCHTl97/2D6V89QTm37quVFxprm0qFNeG68piZcR5HDCedO6PkiMUQECQQC5IUMH
1r1Z1RVC1X2bfjI/onNgxqCQr8XbFKg6PpN/ZxBjBwUv0jSxK6xNXfv/ztL/tAya
EEHtHp+27EjC5plt
-----END RSA PRIVATE KEY-----"


    Alipay::Mobile::Service.mobile_securitypay_pay_string({
      seller_id: 'dashengtianqi@aliyun.com',
      out_trade_no: payment_no,
      notify_url: 'http://101.200.197.162/api/notify/alipay',
      subject: '订单支付',
      # total_fee: original_amount,
      total_fee: 0.01,
      body: '订单支付'
    }, {
      sign_type: 'RSA',
      key: rsa_private_key
    })

  

  end

end
