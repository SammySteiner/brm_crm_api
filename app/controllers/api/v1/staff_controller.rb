class Api::V1::StaffController < ApplicationController
  before_action :authorize_user!

  def index
    @staff = Staff.includes(:agency, :role)
    render json: @staff
  end

  def create
    agency = Agency.find_by(name: staff_params['agency'])
    role = Role.find_by(title: staff_params['role'])
    if staff_params['agency'] === "INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF"
      staff = Staff.find_or_create_by(first_name: staff_params['first_name'], last_name: staff_params['last_name'], email: staff_params['email'], office_phone: staff_params['office_phone'], cell_phone: staff_params['cell_phone'], agency: agency, role: role)
      if staff_params['role'] === 'CIO'
        CioAgency.create(cio_id: staff.id, agency: agency)
      elsif staff_params['role'] === 'Commissioner'
        CommissionerAgency.create(commissioner_id: staff.id, agency: agency)
      elsif staff_params['role'] === 'SDL'
        staff_params['service'].each do |ser|
          service = Service.find_by(title: ser)
          service.sdl_id = staff.id
          service.save
        end
      elsif staff_params['role'] === 'ARM'
        staff_params['assignments'].each do |as|
          agency = Agency.find_by(name: as)
          ArmAgency.create(arm_id: staff.id, agency_id: agency.id)
        end
        render json: staff
      end
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
    agency = Agency.find_by(name: staff_params['agency'])
    role = Role.find_by(title: staff_params['role'])
    staff = Staff.find(staff_params['id'])
    byebug
    if staff_params['agency'] === "INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF"
      staff.update(first_name: staff_params['first_name'], last_name: staff_params['last_name'], email: staff_params['email'], office_phone: staff_params['office_phone'], cell_phone: staff_params['cell_phone'], agency: agency, role: role)
      if staff_params['role'] === "SDL"
        staff_params['services'].each do |service|
          s = Service.find_by(title: service)
          s.update(sdl_id = staff.id)
          s.save
        end
      elsif staff_params['role'] === "Service Owner"
        staff_params['services'].each do |service|
          s = Service.find_by(title: service)
          s.update(service_owner_id = staff.id)
          s.save
        end
      elsif staff_params['role'] === "ARM"
        staff_params['assignments'].each do |assignment|
          a = Agency.find_by(name: assignment)
          ArmAgency.create(arm_id: staff.id, agency: a)
        end
      elsif staff_params['role'] === "Commissioner"
        CommissionerAgency.create(commissioner_id: staff.id, agency: agency)
      elsif staff_params['role'] === "CIO"
        CioAgency.create(cio_id: staff.id, agency: agency)
      end
    else
      if staff_params['role'] === "General"
        staff.update(first_name: staff_params['first_name'], last_name: staff_params['last_name'], email: staff_params['email'], office_phone: staff_params['office_phone'], cell_phone: staff_params['cell_phone'], agency: agency, role: role)
      elsif staff_params['role'] === "Commissioner"
        CommissionerAgency.create(commissioner_id: staff.id, agency: agency)
      elsif staff_params['role'] === "CIO"
        CioAgency.create(cio_id: staff.id, agency: agency)
      end
    end
    staff.save
    render json: staff
  end

  def destroy
    staff = Staff.find(params[:id])
    staff.destroy
    if staff.role_id === Role.find_by(title: "SDL").id
      services = Service.where(sdl_id: staff.id)
      services.each do |service| service.update(sdl_id: nil) end
    end
    render json: staff
  end

  def show
    s = Staff.find(params[:id])
    services = Service.where(sdl_id: s.id)
    staff_details = {id: s.id, first_name: s.first_name, last_name: s.last_name, fullname: s.fullname, email: s.email, office_phone: s.office_phone, cell_phone: s.cell_phone, role: s.role, agency: s.agency, assignments: s.assignments, services: services}
    render json: staff_details
  end

  def formInfo
    staff_info = Staff.select(:id, :first_name, :last_name, :email, :office_phone, :cell_phone, :role_id, :agency_id)
    role_info = Role.select(:id, :title)
    agencies_info = Agency.select(:id, :name, :acronym)
    arm_info = ArmAgency.select(:id, :arm_id, :agency_id)
    service_info = Service.select(:id, :title, :sdl_id, :service_owner_id)
    staff_form_info = {staff: staff_info, role: role_info, agencies: agencies_info, arms: arm_info, service: service_info}
    render json: staff_form_info
  end


  private

  def staff_params
    params.require(:staff).permit(:id, :first_name, :last_name, :email, :office_phone, :cell_phone, :agency, :role, :service, :agencyNames, :roles, :staff, :services => [], :assignments => [])
  end

end
