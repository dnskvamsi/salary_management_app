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
require 'rails_helper'

RSpec.describe Address, type: :model do
  #schema
  [:line_1, :line_2, :city].each do |column_name|
    it { is_expected.to have_db_column(column_name).of_type(:string) }
  end

  it { is_expected.to have_db_column(:state).of_type(:integer) }
  it { is_expected.to have_db_column(:country).of_type(:integer) }

  it { is_expected.to belong_to(:employee) }

  # Validations

  [:line_1, :line_2, :city, :state, :country].each do |field|
    it { should validate_presence_of(field) }
  end

  it { should define_enum_for(:state).with_values(LOCATIONS.values.inject(&:merge))}
  it { should define_enum_for(:country).with_values(LOCATIONS.keys) }
end
