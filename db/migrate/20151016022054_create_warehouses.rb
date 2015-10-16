class CreateWarehouses < ActiveRecord::Migration
  def change
    create_table :warehouses do |t|      
      t.belongs_to :region
      t.string :name, null: false
      t.string :business_time
      t.string :address, null: false
      t.text :content
      t.string :url
      t.timestamps null: false
    end
  end
end
