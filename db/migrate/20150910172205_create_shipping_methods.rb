class CreateShippingMethods < ActiveRecord::Migration
  def change
    create_table :shipping_methods do |t|
      t.string :name
      t.boolean :active
      t.datetime :created_at
      t.datetime :updated_at
      t.decimal :price
      t.integer :shipping_service_id

      t.timestamps null: false
    end
  end
end
