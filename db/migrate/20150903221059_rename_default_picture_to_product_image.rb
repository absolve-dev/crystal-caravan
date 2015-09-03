class RenameDefaultPictureToProductImage < ActiveRecord::Migration
  def change
    rename_column :products, :default_picture, :product_image
  end
end
