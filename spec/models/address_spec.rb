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
require 'rails_helper'

RSpec.describe Address, type: :model do
  #schema
  [:line_1, :line_2, :city].each do |column_name|
    it { is_expected.to have_db_column(column_name).of_type(:string) }
  end

  it { is_expected.to belong_to(:employee) }

  # Validations

  [:line_1, :line_2, :city, :state].each do |field|
    it { should validate_presence_of(field) }
  end

  it { should define_enum_for(:state).with_values(
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
  )}
end
