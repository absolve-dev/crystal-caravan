class AddPersistenceOfListingToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :persisted_name, :string
    add_column :line_items, :persisted_listing_name, :string
    add_column :line_items, :persisted_price, :decimal
  end
end
