class CreateShippingServices < ActiveRecord::Migration
  def change
    create_table :shipping_services do |t|
      t.string :name
      t.boolean :active
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps null: false
    end
  end
end
