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

  it { is_expected.to have_one(:address).dependent(:destroy) }

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
    ) 
  }

  context 'scopes' do
    describe '#with_job_title' do
      it 'fetchs only records with given job title' do
        employee1 = create(:employee, job_title: 1)
        employee2 = create(:employee, job_title: 2)

        records = Employee.with_job_title(1)

        expect(records).to eq([employee1])
        expect(records).not_to include(employee2)
      end
    end

    describe '#with_state' do
      it 'returns records only from the given state' do
        employee1 = create(:address, state: 1, employee: create(:employee)).employee
        employee2 = create(:address, state: 2, employee: create(:employee)).employee

        records = Employee.with_state(1)

        expect(records).to eq([employee1])
        expect(records).not_to include(employee2)
      end
    end
  end
end
