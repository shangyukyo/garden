class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.belongs_to :city
      t.string :name, null: false      
      t.timestamps null: false
    end
  end
end
