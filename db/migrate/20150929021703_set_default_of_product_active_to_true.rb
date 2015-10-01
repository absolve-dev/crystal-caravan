class SetDefaultOfProductActiveToTrue < ActiveRecord::Migration
  def change
    change_column :products, :active, :boolean, :default => true
  end
end
