# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  first_name :string
#  job_title  :integer
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

  [:first_name, :salary, :last_name, :job_title].each do |field|
    it { should validate_presence_of(field) }
  end

  it { should define_enum_for(:job_title).with_values(
      software_engineer: 0,
      marketing_manager: 1,
      project_manager: 2,
      financial_analyst: 3,
      graphic_designer: 4,
      data_scientist: 5,
      human_resources_specialist: 6,
      registered_nurse: 7,
      sales_representative: 8,
      operations_coordinator: 9
    ) }
end
