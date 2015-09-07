class Coupon < ActiveRecord::Base

  validates :start_at,  presence: true
  validates :expired_at,  presence: true

  enum coupon_type: {
    default: 0    
  }  

  def give_to users
    users.each do |user|
      user.coupons << self      
    end
  end
  
end
