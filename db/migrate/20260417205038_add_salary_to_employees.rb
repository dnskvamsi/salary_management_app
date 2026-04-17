class AddSalaryToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :salary, :decimal
  end
end
