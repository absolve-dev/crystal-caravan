class AddImageToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :default_picture, :string
  end
end
