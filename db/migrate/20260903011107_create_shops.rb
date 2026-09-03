class CreateShops < ActiveRecord::Migration[8.1]
  def change
    create_table :shops do |t|
      t.timestamps
    end
  end
end
