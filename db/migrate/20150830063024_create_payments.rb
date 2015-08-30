class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :transaction_id
      t.string :order_id
      t.string :gateway
      t.decimal :amount
      t.integer :status
      t.string :response_message

      t.timestamps null: false
    end
  end
end
