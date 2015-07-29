class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :province
      t.string :city
      t.string :region
      t.string :name            
      t.timestamps null: false
    end
  end

end
