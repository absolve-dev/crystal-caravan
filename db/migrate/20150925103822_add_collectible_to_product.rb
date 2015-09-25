class AddCollectibleToProduct < ActiveRecord::Migration
  def change
    add_column :products, :collectible, :boolean, :default => true
  end
end
