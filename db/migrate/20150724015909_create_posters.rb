class CreatePosters < ActiveRecord::Migration
  def change
    create_table :posters do |t|
      t.integer :asset_id
      t.integer :good_id
      t.text :ext
      t.timestamps null: false
    end
  end
end
