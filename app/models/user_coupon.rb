class UserCoupon < ActiveRecord::Base
  belongs_to :user
  belongs_to :coupon

  enum status: {
    pending: 0,
    used: -1
  }
end
