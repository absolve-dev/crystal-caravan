class RemoveNifty < ActiveRecord::Migration
  def change
    drop_table :nifty_attachments
  end
end
