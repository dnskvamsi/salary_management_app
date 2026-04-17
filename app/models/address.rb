# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  city        :string
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
class Address < ApplicationRecord
  belongs_to :employee

  validates_presence_of :line_1, :line_2, :city, :state

  enum :state, {
    andhra_pradesh: 0,
    arunachal_pradesh: 1,
    assam: 2,
    bihar: 3,
    chhattisgarh: 4,
    goa: 5,
    gujarat: 6,
    haryana: 7,
    himachal_pradesh: 8,
    jharkhand: 9,
    karnataka: 10,
    kerala: 11,
    madhya_pradesh: 12,
    maharashtra: 13,
    manipur: 14,
    meghalaya: 15,
    mizoram: 16,
    nagaland: 17,
    odisha: 18,
    punjab: 19
  }
end
