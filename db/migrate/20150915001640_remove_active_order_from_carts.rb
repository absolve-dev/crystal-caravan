class RemoveActiveOrderFromCarts < ActiveRecord::Migration
  def change
    remove_column :carts, :active_order
  end
end
