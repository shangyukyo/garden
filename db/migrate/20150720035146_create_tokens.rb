class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :mobile    
      t.string :body
      t.integer :token_type, null:false, default: 0
      t.integer :status, null: false, default: 0
      t.text :ext
      t.timestamps null: false
    end

    add_index :tokens, :mobile
  end
end
