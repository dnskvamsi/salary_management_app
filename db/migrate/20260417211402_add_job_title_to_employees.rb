class AddJobTitleToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_column :employees, :job_title, :integer
  end
end
