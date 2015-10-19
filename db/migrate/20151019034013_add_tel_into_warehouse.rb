class AddTelIntoWarehouse < ActiveRecord::Migration
  def change
    add_column :warehouses, :tel, :string, after: :address  
  end
end
