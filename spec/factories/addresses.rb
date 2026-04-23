# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  city        :string
#  country     :integer
#  line_1      :string
#  line_2      :string
#  state       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :integer
#
# Indexes
#
#  index_addresses_on_employee_id  (employee_id)
#
FactoryBot.define do
  factory :address do
    city { "MyString" }
    state { :andhra_pradesh }
    line_1 { "MyString" }
    line_2 { "MyString" }
  end
end
