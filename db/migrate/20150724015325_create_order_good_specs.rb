class CreateOrderGoodSpecs < ActiveRecord::Migration
  def change
    create_table :order_good_specs do |t|
      t.belongs_to :order
      t.integer :good_spec_id
      t.decimal :price, precision: 16, scale: 3, null: false, default: 0.0
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
