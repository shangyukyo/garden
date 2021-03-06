class CreateUserCoupons < ActiveRecord::Migration
  def change
    create_table :user_coupons do |t|
      t.belongs_to :user, index: true
      t.belongs_to :coupon, index: true
      t.integer :status, null: false, default: 0
      t.timestamps null: false
    end
  end
end
