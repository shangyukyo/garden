class AddTargetGetRegistCouponIntoUsers < ActiveRecord::Migration
  def change
  	add_column :users, :target_get_regist_coupon, :boolean, null: false, default: false, after: :get_regist_coupon 
  end
end
