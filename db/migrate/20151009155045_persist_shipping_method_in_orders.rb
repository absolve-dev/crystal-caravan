class PersistShippingMethodInOrders < ActiveRecord::Migration
  def change
    add_column :orders, :persisted_shipping_service_name, :string
    add_column :orders, :persisted_shipping_method_name, :string
    add_column :orders, :persisted_shipping_method_price, :decimal, :precision => 8, :scale => 2
  end
end
