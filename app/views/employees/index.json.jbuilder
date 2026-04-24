json.employees @employees do |employee|
  json.id employee.id
  json.full_name "#{employee.first_name} #{employee.last_name}"
  json.job_title employee.job_title&.titleize
  json.salary number_to_currency(employee.salary, precison: 2, currency: '$')
  json.address displayable_address(employee)
end

json.meta do
  json.total_count @employees.total_count
  json.total_pages @employees.total_pages
  json.current_page @employees.current_page
end