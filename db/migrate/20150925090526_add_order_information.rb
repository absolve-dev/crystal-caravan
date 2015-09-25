class AddOrderInformation < ActiveRecord::Migration
  def change
    add_column :orders, :cart_id, :integer
    add_column :orders, :order_status, :integer, :default => 0
    add_column :orders, :origin_ip, :string
    add_column :orders, :payment_id, :integer
  end
end
