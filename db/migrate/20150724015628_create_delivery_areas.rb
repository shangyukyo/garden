class CreateDeliveryAreas < ActiveRecord::Migration
  def change
    create_table :delivery_areas do |t|
      t.string :province
      t.string :city
      t.string :region
      t.string :address      
      t.timestamps null: false
    end
  end
end
