class Api::V1::ServicesController < ApplicationController
  before_action :authorize_user!

  def index
    services = Service.includes(:sdl, :division)
    render json: services
  end

  def create
    sdl_id = Staff.find_by(first_name: service_params[:sdl].split(' ')[0], last_name: service_params[:sdl].split(' ')[1]).id
    division_id = Division.find_by(name: service_params['division']).id
    service = Service.create(title: service_params['title'], description: service_params['description'], sla: service_params['sla'], sdl_id: sdl_id, division_id: division_id)
    render json: service
  end

  def update
    service = Service.find(service_params['id'])
    sdl_id = Staff.find_by(first_name: service_params[:sdl].split(' ')[0], last_name: service_params[:sdl].split(' ')[1]).id
    division_id = Division.find_by(name: service_params['division']).id
    service.update(title: service_params['title'], description: service_params['description'], sla: service_params['sla'], sdl_id: sdl_id, division_id: division_id)
    render json: service

  end

  def destroy
    service = Service.find(params[:id])
    service.destroy
    render json: service
  end

  def show
    s = Service.find(params[:id])
    service_details = {id: s.id, title: s.title, description: s.description, sla: s.sla, sdl: s.sdl, division: s.division, deputy_commissioner: s.division.deputy_commissioner}
    render json: service_details
  end

  def formInfo
    doitt_id = Agency.find_by(name: 'INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF').id
    staff = Staff.select(:first_name, :last_name).where(agency_id: doitt_id)
    staff_info = staff.map do |s|
      s.fullname
    end
    division_info = Division.select(:name)
    service_info = Service.select(:id, :title, :sdl_id)
    staff_form_info = {staff: staff_info, divisions: division_info, services: service_info}
    render json: staff_form_info.to_json
  end


  private

  def service_params
    params.require(:service).permit(:id, :title, :description, :sla, :sdl, :division)
  end

end
