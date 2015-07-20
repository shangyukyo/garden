class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|

      t.string :name
      t.text :ext
      t.timestamps null: false
      t.datetime :deleted_at, default: nil
    end
  end
end
