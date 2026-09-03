class AddBookmarkedToMicroposts < ActiveRecord::Migration[8.1]
  def change
    add_column :microposts, :bookmarked, :boolean
  end
end
