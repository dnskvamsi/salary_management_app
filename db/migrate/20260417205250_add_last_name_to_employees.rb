class AddLastNameToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :last_name, :string
  end
end
