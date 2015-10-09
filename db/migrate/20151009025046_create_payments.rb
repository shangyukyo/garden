class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :user      
      t.string :payment_no, null: false, limit: 191
      t.string :subject, null: false      
      t.decimal :original_amount, precision: 16, scale: 3, null: false, default: 0.0
      t.decimal :amount, precision: 16, scale: 3, null: false, default: 0.0
      t.integer :gateway, default: 0
      t.string :gateway_transacation_id
      t.boolean :notified, default: false
      t.integer :status, default: 0
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
