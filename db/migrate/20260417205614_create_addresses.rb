class CreateAddresses < ActiveRecord::Migration[8.1]
  def change
    create_table :addresses do |t|
      t.string :city
      t.integer :state
      t.string :line_1
      t.string :line_2
      t.references :employee, index: true

      t.timestamps
    end
  end
end
