class CreateOrderPayments < ActiveRecord::Migration
  def change
    create_table :order_payments do |t|
      t.string :order_id, index: true, null: false
      t.string :payment_no, index: true, null: false
      t.timestamps null: false
    end

    add_index :order_payments, [:order_id, :payment_no]
  end
end
