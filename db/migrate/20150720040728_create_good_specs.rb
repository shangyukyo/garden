class CreateGoodSpecs < ActiveRecord::Migration
  def change
    create_table :good_specs do |t|

      t.belongs_to :good, index: true
      t.integer :status
      t.string :name
      t.text :description      
      t.decimal :origin_price, precision: 16, scale: 3, null: false, default: 0.0
      t.decimal :price, precision: 16, scale: 3, null: false, default: 0.0     
      t.timestamps null: false
      t.datetime :deleted_at
    end

  end

end
