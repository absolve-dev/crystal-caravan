class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category_id
      t.string :permalink
      t.string :description
      t.string :short_description
      t.boolean :active
      t.decimal :weight
      t.datetime :created
      t.integer :update_id

      t.timestamps null: false
    end
  end
end
