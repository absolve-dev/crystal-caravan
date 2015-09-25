class ChangeCartToAddActive < ActiveRecord::Migration
  def change
    add_column :carts, :active, :boolean, :default => true
  end
end
