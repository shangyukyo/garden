# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Coupon.create!(name: "新注册用户优惠券", price: 10, coupon_type: Coupon.coupon_types[:new_user], start_at: '2015-01-01 00:00:00', expired_at: '2100-01-01 00:00:00')

Coupon.create!(name: "消费满100元优惠券", price: 10, coupon_type: Coupon.coupon_types[:consume_100], start_at: '2015-01-01 00:00:00', expired_at: '2100-01-01 00:00:00')