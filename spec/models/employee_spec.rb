# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  first_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Employee, type: :model do

  #schema
  it { is_expected.to have_db_column(:first_name).of_type(:string) }

  # Validations

  it { should validate_presence_of(:first_name) }
end
