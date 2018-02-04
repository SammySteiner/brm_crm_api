class Api::V1::StaffController < ApplicationController

  def index
    @staff = Staff.includes(:agency, :role)
    render json: @staff
  end

  def create
    agency = Agency.find_by(name: staff_params['agency'])
    role = Role.find_by(title: staff_params['role'])
    if staff_params['agency'] === "INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF"
      staff = Staff.find_or_create_by(staff_params)
      #  doitt staff
      # check first and last name?

    else
      staff = Staff.find_or_create_by(first_name: staff_params['first_name'], last_name: staff_params['last_name'], email: staff_params['email'], office_phone: staff_params['office_phone'], cell_phone: staff_params['cell_phone'], agency: agency, role: role)
      if staff_params['role'] === 'CIO'
        CioAgency.create(cio_id: staff.id, agency: agency)
      elsif staff_params['role'] === 'Commissioner'
        CommissionerAgency.create(commissioner_id: staff.id, agency: agency)
      elsif staff_params['role'] === 'other'
        OtherAgency.create(staff_id: staff_id, agency: agency)
      end
      render json: staff
    end
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

  def formInfo
    staff_info = Staff.select(:id, :first_name, :last_name, :email, :office_phone, :cell_phone)
    role_info = Role.select(:id, :title)
    agency_info = Agency.select(:id, :name)
    service_info = Service.select(:id, :title)
    staff_form_info = {staff: staff_info, role: role_info, agency: agency_info, service: service_info}
    render json: staff_form_info.to_json
  end


  private

  def staff_params
    params.require(:staff).permit(:id, :first_name, :last_name, :email, :office_phone, :cell_phone, :agency, :role, :service, :agencyNames, :roles, :staff, :services)
  end

end
