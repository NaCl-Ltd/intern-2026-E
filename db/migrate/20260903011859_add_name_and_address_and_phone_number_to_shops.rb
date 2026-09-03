class AddNameAndAddressAndPhoneNumberToShops < ActiveRecord::Migration[8.1]
  def change
    add_column :shops, :name, :string
    add_column :shops, :address, :string
    add_column :shops, :phone_number, :string
  end
end
