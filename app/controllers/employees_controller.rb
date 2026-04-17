class EmployeesController < ApplicationController
  def new
    @employee = Employee.new
  end

  def index
    @employees = Employee.all
  end
end
