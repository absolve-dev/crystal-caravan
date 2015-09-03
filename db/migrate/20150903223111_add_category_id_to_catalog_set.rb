class AddCategoryIdToCatalogSet < ActiveRecord::Migration
  def change
    add_column :catalog_sets, :category_id, :integer
  end
end
