class FixLineitemModel < ActiveRecord::Migration
  def change
    remove_column :line_items, :product_id
    add_column :line_items, :listing_id, :integer
  end
end
