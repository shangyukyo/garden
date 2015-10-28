class AddMinimumIntoCoupon < ActiveRecord::Migration
  def change
    add_column :coupons, :minimum, :decimal, precision: 16, scale: 3, null: false, default: 0.0, after: :price
  end
end
