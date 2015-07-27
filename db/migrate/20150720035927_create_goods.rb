class CreateGoods < ActiveRecord::Migration
  def change
    create_table :goods do |t|
      t.string :name
      t.text :description
      t.integer :status, null: false, default: 0  
      t.decimal :origin_price, precision: 16, scale: 3, null: false, default: 0.0
      t.decimal :price, precision: 16, scale: 3, null: false, default: 0.0      
      t.text :ext
      t.timestamps null: false
      t.datetime :deleted_at
    end

    add_index :goods, :status
  end
end
