class CreateOrderGoods < ActiveRecord::Migration
  def change
    create_table :order_goods do |t|
      t.belongs_to :order
      t.integer :good_id
      t.decimal :price, precision: 16, scale: 3, null: false, default: 0.0
      t.integer :quantity
      t.text :ext
      t.timestamps null: false
    end
  end
end
