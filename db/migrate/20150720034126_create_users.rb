class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|

      t.string :mobile, null: false
      t.string :avatar
      t.string :private_token   
      t.text :ext   
      t.timestamps null: false
      t.datetime :deleted_at, default: nil
    end
  end
end
