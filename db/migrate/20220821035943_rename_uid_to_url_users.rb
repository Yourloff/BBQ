class RenameUidToUrlUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :uid, :url
  end
end
