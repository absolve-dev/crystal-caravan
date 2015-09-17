class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
      t.string :description
      t.string :permalink
      t.string :default_picture

      t.timestamps null: false
    end
  end
end
