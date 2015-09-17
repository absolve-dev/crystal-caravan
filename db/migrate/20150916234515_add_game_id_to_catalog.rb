class AddGameIdToCatalog < ActiveRecord::Migration
  def change
    add_column :catalogs, :game_id, :integer
  end
end
