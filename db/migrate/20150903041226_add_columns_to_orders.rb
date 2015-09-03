class AddColumnsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cart_id, :integer
    add_column :orders, :order_status, :integer, default: 0
    add_column :orders, :origin_ip, :string
  end
end
