class AddDefaultListing < ActiveRecord::Migration
  def change
    add_column :products, :default_listing_id, :integer
  end
end
