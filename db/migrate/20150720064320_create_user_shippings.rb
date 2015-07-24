class CreateUserShippings < ActiveRecord::Migration
  def change
    create_table :user_shippings do |t|
      t.belongs_to :user, index: true
      t.integer :type
      t.string :state
      t.string :city
      t.string :region
      t.string :address
      t.string :zip_code
      t.string :name
      t.string :mobile          
      t.timestamps null: false
    end
  end
end