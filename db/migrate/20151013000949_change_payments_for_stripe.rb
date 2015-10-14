class ChangePaymentsForStripe < ActiveRecord::Migration
  def change
    rename_column :payments, :transaction_id, :stripe_charge_id
    add_column :payments, :stripe_refund_id, :string
  end
end
