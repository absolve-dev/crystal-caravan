class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :name
      t.integer :product_id
      t.decimal :price
      t.integer :quantity
      t.boolean :active
      t.datetime :update_id

      t.timestamps null: false
    end
  end
end
