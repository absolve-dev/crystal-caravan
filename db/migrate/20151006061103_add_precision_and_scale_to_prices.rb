class AddPrecisionAndScaleToPrices < ActiveRecord::Migration
  def change
    change_column :line_items, :persisted_price, :decimal, :precision => 8, :scale => 2 
    change_column :listings, :price, :decimal, :precision => 8, :scale => 2
    change_column :shipping_methods, :price, :decimal, :precision => 8, :scale => 2
  end
end
