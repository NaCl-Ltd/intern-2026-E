class CreateLikes < ActiveRecord::Migration[8.1]
  def change
    create_table :likes do |t|
      t.references :users, null: false, foreign_key: true
      t.references :microposts, null: false, foreign_key: true

      t.timestamps
    end

    add_index :likes, [:users_id, :microposts_id], unique: true
  end
end
