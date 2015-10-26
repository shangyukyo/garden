class AddLongitudeAndLatitudeIntoWarehouse < ActiveRecord::Migration
  def change
    add_column :warehouses, :longitude, :string, after: :address     
    add_column :warehouses, :latitude, :string, after: :longitude
  end
end
