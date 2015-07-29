class CreateUserShippings < ActiveRecord::Migration
  def change
    create_table :user_shippings do |t|
      t.belongs_to :user, index: true
      t.integer :default
      t.string :area
      t.string :school
      t.string :address
      t.string :name
      t.string :mobile          
      t.timestamps null: false
    end
  end
end