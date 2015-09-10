class AddLibraryNameToCatalogs < ActiveRecord::Migration
  def change
    add_column :catalogs, :library_name, :string
  end
end
