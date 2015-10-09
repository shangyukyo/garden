class OrderPayment < ActiveRecord::Base
  
  belongs_to :order
  belongs_to :payment, foreign_key: 'payment_no'
end
