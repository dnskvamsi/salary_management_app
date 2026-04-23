class AddCountryToAddresses < ActiveRecord::Migration[8.1]
  def change
    add_column :addresses, :country, :integer
  end
end
