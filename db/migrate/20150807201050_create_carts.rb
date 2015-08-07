class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer :session_id

      t.timestamps null: false
    end
  end
end
