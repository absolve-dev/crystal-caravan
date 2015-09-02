class CreateCatalogCards < ActiveRecord::Migration
  def change
    create_table :catalog_cards do |t|
      t.string :name
      t.integer :catalog_set_id
      t.string :card_data_json

      t.timestamps null: false
    end
  end
end
