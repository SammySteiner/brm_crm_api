class Api::V1::ServicesController < ApplicationController
  before_action :authorize_user!

  def index
    services = Service.includes(:sdl, :division, :service_owner).map do |s|
      if s.sdl.present?
        sdl_fullname = s.sdl.fullname
        sdl_last_name = s.sdl.last_name
      else
        sdl_fullname = nil
        sdl_last_name = nil

      end
      if s.service_owner.present?
        so_fullname = s.service_owner.fullname
        so_last_name = s.service_owner.last_name
      else
        so_fullname = nil
        so_last_name = nil

      end
      {id: s.id, title: s.title, description: s.description, division: s.division.name, sdl: {fullname: sdl_fullname, last_name: sdl_last_name}, service_owner: {fullname: so_fullname, last_name: so_last_name}}
    end
    render json: services
  end

  def create
    sdl_id = Staff.find_by(first_name: service_params[:sdl].split(' ')[0], last_name: service_params[:sdl].split(' ')[1]).id
    service_owner_id = Staff.find_by(first_name: service_params[:service_owner].split(' ')[0], last_name: service_params[:service_owner].split(' ')[1]).id
    division_id = Division.find_by(name: service_params['division']).id
    service = Service.create(title: service_params['title'], description: service_params['description'], sla: service_params['sla'], sdl_id: sdl_id, service_owner_id: service_owner_id, division_id: division_id)
    render json: service
  end

  def update
    service = Service.find(service_params['id'])
    sdl_id = Staff.find_by(first_name: service_params[:sdl].split(' ')[0], last_name: service_params[:sdl].split(' ')[1]).id
    service_owner_id = Staff.find_by(first_name: service_params[:service_owner].split(' ')[0], last_name: service_params[:service_owner].split(' ')[1]).id
    division_id = Division.find_by(name: service_params['division']).id
    service.update(title: service_params['title'], description: service_params['description'], sla: service_params['sla'], sdl_id: sdl_id, service_owner_id: service_owner_id, division_id: division_id)
    render json: service
  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
    render json: service
  end

  def show
    s = Service.find(params[:id])
    service_details = {id: s.id, title: s.title, description: s.description, sla: s.sla, sdl: s.sdl, division: s.division, deputy_commissioner: s.division.deputy_commissioner, service_owner: s.service_owner}
    render json: service_details
  end

  def formInfo
    doitt_id = Agency.find_by(name: 'INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF').id
    staff = Staff.select(:first_name, :last_name).where(agency_id: doitt_id).map { |s| s.fullname }
    so_staff = Staff.select(:first_name, :last_name).where(agency_id: doitt_id, role: Role.find_by(title: "Service Owner")).map { |s| s.fullname }
    sdl_staff = Staff.select(:first_name, :last_name).where(agency_id: doitt_id, role: Role.find_by(title: "SDL")).map { |s| s.fullname }
    division_info = Division.select(:name)
    service_info = Service.select(:id, :title, :sdl_id)
    staff_form_info = {staff: staff, divisions: division_info, services: service_info, so_staff: so_staff, sdl_staff: sdl_staff}
    render json: staff_form_info.to_json
  end


  private

  def service_params
    params.require(:service).permit(:id, :title, :description, :sla, :sdl, :service_owner, :division)
  end

end
