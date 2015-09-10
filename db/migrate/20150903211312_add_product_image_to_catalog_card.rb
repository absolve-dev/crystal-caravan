class AddProductImageToCatalogCard < ActiveRecord::Migration
  def change
    add_column :catalog_cards, :product_image, :string
  end
end
