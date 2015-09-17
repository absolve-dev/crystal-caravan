class ChangeCategoriesForGamesStructure < ActiveRecord::Migration
  def change
    remove_column :categories, :category_id
    add_column :categories, :game_id, :integer
  end
end
