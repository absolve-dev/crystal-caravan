class AddProductIdToCatalogCard < ActiveRecord::Migration
  def change
    add_column :catalog_cards, :product_id, :integer
  end
end
