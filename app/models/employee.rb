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
class Employee < ApplicationRecord

  has_one :address, dependent: :destroy
  validates_presence_of :first_name, :salary, :last_name, :job_title
  accepts_nested_attributes_for :address

  filterrific(
    available_filters: [
      :with_job_title,
      :with_state
    ]
  )

  scope :with_job_title, ->(job_titles) {
    return nil if job_titles.blank?
    where(job_title: Array(job_titles).reject(&:blank?))
  }

  scope :with_state, ->(states) {
    return nil if states.blank?
    joins(:address).where(
      addresses: { state: Array(states).reject(&:blank?) }
    )
  }

  enum :job_title, {
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
  }
end
