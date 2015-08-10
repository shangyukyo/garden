class AddStatusIntoCategories < ActiveRecord::Migration
  def change
    add_column :categories, :status, :integer, null: false, default: 0, after: :category_type  
  end
end
