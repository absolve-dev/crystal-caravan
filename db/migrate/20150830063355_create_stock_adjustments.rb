class CreateStockAdjustments < ActiveRecord::Migration
  def change
    create_table :stock_adjustments do |t|
      t.integer :order_id
      t.integer :listing_id
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
