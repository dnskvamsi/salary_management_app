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
FactoryBot.define do
  factory :employee do
    first_name { 'First Name' }
    last_name { 'Last Name' }
    job_title { 0 }
    salary { 20000 }
  end
end
