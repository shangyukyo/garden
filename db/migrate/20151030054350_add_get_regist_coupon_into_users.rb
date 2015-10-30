class AddGetRegistCouponIntoUsers < ActiveRecord::Migration
  def change
    add_column :users, :get_regist_coupon, :boolean, null: false, default: false, after: :private_token 
  end
end
