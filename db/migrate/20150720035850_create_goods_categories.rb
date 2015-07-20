class CreateGoodsCategories < ActiveRecord::Migration
  def change
    create_table :goods_categories do |t|
      t.belongs_to :good, index: true
      t.belongs_to :category, index: true
      t.timestamps null: false
    end

    add_index :goods_categories, [:good_id, :category_id]
  end
end
