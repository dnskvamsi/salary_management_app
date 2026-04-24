module EmployeesHelper
  def displayable_name(employee)
    employee.first_name + " " + employee.last_name
  end

  def displayable_address(employee)
    address = employee.address
    "#{address.line_1} #{address.line_2} #{address.city} #{address.state.humanize}, #{address.country.titleize}"
  end
end
