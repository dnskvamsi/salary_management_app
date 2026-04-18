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
    @filterrific = initialize_filterrific(
      Employee,
      params[:filterrific],
      select_options: {
        with_job_title: Employee.job_titles.map { |name, id| [name.humanize.titleize, id] },
        with_state: Address.states.map { |name, id| [name.humanize.titleize, id] }
      }
    ) || return

    filtered_relation = @filterrific.find

    @stats = {
      count: filtered_relation.count,
      avg_salary: filtered_relation.average(:salary).to_f,
      min_salary: filtered_relation.minimum(:salary).to_f,
      max_salary: filtered_relation.maximum(:salary).to_f
    }
    
    @employees = @filterrific.find.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.js
    end
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