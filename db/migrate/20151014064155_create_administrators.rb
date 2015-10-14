class CreateAdministrators < ActiveRecord::Migration
  def change
    create_table :administrators do |t|

      t.string :mobile, null: false
      t.string :password_digest, null: false
      t.boolean :admin_power, default: false
      t.boolean :edit_power, default: false
      t.boolean :order_power, default: false
      t.text :ext   
      t.timestamps null: false
      t.datetime :deleted_at, default: nil
    end
  end
end
