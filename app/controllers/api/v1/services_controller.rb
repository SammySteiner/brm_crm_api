class Api::V1::ServicesController < ApplicationController

  def index
    services = Service.all
    render json: services
  end

  def create

  end

  def update

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

  private

  def staff_params
    params.require(:service).permit(:id)
  end

end
