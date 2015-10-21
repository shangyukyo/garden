class Coupon < ActiveRecord::Base

  validates :start_at,  presence: true
  validates :expired_at,  presence: true

  enum coupon_type: {
    default: 0,
    new_user: 1,
    consume_100: 2
  }

  scope :effect_coupons, -> {where("start_at < ? and expired_at > ?", Time.now, Time.now)}

  def give_to users
    users.each do |user|
      user.coupons << self      
    end
  end


  def effect?
    Time.now > start_at and Time.now < expired_at
  end
  

  def self.change_name
    Coupon.new_user.update_all name: "新用户大反馈"
    Coupon.consume_100.update_all name: "推广优惠券"
  end
  
end
