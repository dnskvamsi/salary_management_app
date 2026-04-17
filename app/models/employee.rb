# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  salary     :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Employee < ApplicationRecord

  has_one :address
  validates_presence_of :first_name, :salary, :last_name
end
