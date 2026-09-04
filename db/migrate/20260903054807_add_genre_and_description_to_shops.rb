class AddGenreAndDescriptionToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :genre, :string
    add_column :shops, :description, :text
  end
end
