class AddFirstNameToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :first_name, :string
  end
end
