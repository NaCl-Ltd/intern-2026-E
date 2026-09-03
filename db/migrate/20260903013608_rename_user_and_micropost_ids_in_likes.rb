class RenameUserAndMicropostIdsInLikes < ActiveRecord::Migration[8.1]
  def change
    rename_column :likes, :users_id, :user_id
    rename_column :likes, :microposts_id, :micropost_id
  end
end
