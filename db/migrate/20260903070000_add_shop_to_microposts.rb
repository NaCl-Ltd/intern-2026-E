class AddShopToMicroposts < ActiveRecord::Migration[8.1]
  def change
    add_reference :microposts, :shop, foreign_key: true
  end
end