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
require 'rails_helper'

RSpec.describe Employee, type: :model do

  #schema
  it { is_expected.to have_db_column(:first_name).of_type(:string) }
  it { is_expected.to have_db_column(:last_name).of_type(:string) }
  it { is_expected.to have_db_column(:salary).of_type(:decimal) }

  it { is_expected.to have_one(:address) }

  # Validations

  [:first_name, :salary, :last_name].each do |field|
    it { should validate_presence_of(field) }
  end
end
