class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|

      t.string :mobile    
      t.string :body
      t.integer :type, null:false
      t.integer :status, null: false
      t.text :ext
      t.timestamps null: false

    end

    add_index :tokens, :mobile
  end
end
