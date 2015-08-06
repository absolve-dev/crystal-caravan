class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :category_id
      t.string :description
      t.string :permalink
      t.datetime :created
      t.integer :update_id

      t.timestamps null: false
    end
  end
end
