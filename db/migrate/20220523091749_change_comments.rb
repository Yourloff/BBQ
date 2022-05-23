class ChangeComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :user_id, :integer, null: true
  end
end
