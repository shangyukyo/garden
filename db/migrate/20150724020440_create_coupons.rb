class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :price, precision: 16, scale: 3, null: false, default: 0.0
      t.string :desc
      t.integer :coupon_type      
      t.datetime :start_at
      t.datetime :expired_at
      t.timestamps null: false
    end
  end
end
