class Order < ActiveRecord::Base
  include AASM

  belongs_to :user
  has_many :order_goods


  enum status: {
    pending:               0,      # 待支付
    paid:                  1,      # 已支付
    delivering:            2,      # 配送中
    canceled:              -1      # 已经取消
  }


end
