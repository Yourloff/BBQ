class RenameColumnUrlToUid < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :url, :uid
  end
end
