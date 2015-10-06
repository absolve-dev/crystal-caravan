class ChangePictureToImage < ActiveRecord::Migration
  def change
    rename_column :games, :default_picture, :default_image
    rename_column :categories, :default_picture, :default_image
  end
end
