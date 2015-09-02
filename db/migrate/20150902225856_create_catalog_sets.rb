class CreateCatalogSets < ActiveRecord::Migration
  def change
    create_table :catalog_sets do |t|
      t.string :name
      t.integer :catalog_id

      t.timestamps null: false
    end
  end
end
