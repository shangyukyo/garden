class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|

      t.belongs_to :user
      t.string :order_no      
      t.decimal :origin_total_price, precision: 16, scale: 3, null: false, default: 0.0
      t.decimal :total_price, precision: 16, scale: 3, null: false, default: 0.0
      t.integer :quantity
      t.integer :status      
      t.text :ext      
      t.timestamps null: false
    end
  end
end
