class AddColumnsToCarts < ActiveRecord::Migration
  def change
    add_column :carts, :active_order, :boolean, default: false
    add_column :carts, :order_id, :integer
  end
end
