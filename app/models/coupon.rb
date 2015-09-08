class Coupon < ActiveRecord::Base

  validates :start_at,  presence: true
  validates :expired_at,  presence: true

  enum coupon_type: {
    default: 0    
  }

  scope :effect_coupons, -> {where("start_at < ? and expired_at > ?", Time.now, Time.now)}

  def give_to users
    users.each do |user|
      user.coupons << self      
    end
  end


  def effect?
    Time.at.now > start_at and Time.at.now < expired_at
  end
  
end
