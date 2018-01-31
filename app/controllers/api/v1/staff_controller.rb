class Api::V1::StaffController < ApplicationController

  def index
    @staff = Staff.includes(:agency, :role)
    render json: @staff
  end

  def create

  end

  def update

  end

  def destroy
    staff = Staff.find(params[:id])
    staff.destroy
    render json: staff
  end

  def show
    s = Staff.find(params[:id])
    staff_details = {id: s.id, first_name: s.first_name, last_name: s.last_name, fullname: s.fullname, email: s.email, office_phone: s.office_phone, cell_phone: s.cell_phone, role: s.role, agency: s.agency, assignments: s.assignments}
    render json: staff_details
  end

  private

  def staff_params
    params.require(:staff).permit(:id)
  end

end
