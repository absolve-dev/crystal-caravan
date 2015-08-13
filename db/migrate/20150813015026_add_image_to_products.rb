class AddImageToProducts < ActiveRecord::Migration
  def change
    add_column :products, :default_picture, :string
  end
end
