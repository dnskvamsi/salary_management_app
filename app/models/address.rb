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
class Address < ApplicationRecord
  belongs_to :employee

  validates_presence_of :line_1, :line_2, :city, :state, :country

  enum :state, LOCATIONS.values.inject(&:merge).freeze
  enum :country, LOCATIONS.keys

  validate :state_must_belong_to_country

  private

  def state_must_belong_to_country
    return if country.blank? || state.blank?

    unless LOCATIONS[country.to_sym]&.include?(state.to_sym)
      errors.add(:base, :invalid_combination)
    end
  end
end
