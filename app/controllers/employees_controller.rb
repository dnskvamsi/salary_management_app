class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :destroy]

  def index
    @employees = Employee.includes(:address).page(params[:page]).per(20)
  end

  def new
    @employee = Employee.new
    @employee.build_address
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to employees_path, notice: "Employee created successfully." }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @employee.address || @employee.build_address
  end

  def update
    if @employee.update(employee_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to employees_path, notice: "Employee updated successfully." }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("employee_#{@employee.id}") }
      format.html { redirect_to employees_path, notice: "Employee deleted." }
    end
  end

  def stats
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(
      :first_name, :last_name, :job_title, :salary,
      address_attributes: [:id, :line_1, :line_2, :city, :state]
    )
  end
end