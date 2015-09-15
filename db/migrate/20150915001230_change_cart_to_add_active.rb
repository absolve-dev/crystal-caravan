class ChangeCartToAddActive < ActiveRecord::Migration
  def change
    remove_column :carts, :order_id
    add_column :carts, :active, :boolean, :default => true
  end
end
