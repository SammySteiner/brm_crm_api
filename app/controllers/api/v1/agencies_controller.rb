class Api::V1::AgenciesController < ApplicationController
  # before_action :authorize_user!

  def index
    agencies = Agency.includes(:arm, :cio, :commissioner)
    render json: agencies
  end

  def create
    agency = Agency.create(agency_params)
    render json: agency
  end

  def update
    agency = Agency.find(agency_params['id'])
    agency.update(name: agency_params['name'], acronym: agency_params['acronym'], category: agency_params['category'], mayoral: agency_params['mayoral'], citynet: agency_params['citynet'], address: agency_params['address'])
    render json: agency
  end

  def destroy
    agency = Agency.find(params[:id])
    staff = agency.staff
    agency.destroy
    render json: staff
  end

  def show
    a = Agency.find(params[:id])
    services = a.services.map { |e| {id: e.id, title: e.title, core: e.core, service_category: e.service_category.name} }
    service_categories = ServiceCategory.all.map { |e| {name: e.name, count: e.services.size} }
    agency_details = {id: a.id, name: a.name, acronym: a.acronym, mayoral: a.mayoral, citynet: a.citynet, category: a.category, address: a.address, commissioner: a.commissioner, cio: a.cio, arm: a.arm, services: services, service_categories: service_categories}
    render json: agency_details
  end

  def formInfo
    agencies_form_info = Agency.select(:id, :name, :acronym)
    render json: agencies_form_info.to_json
  end

  private

  def agency_params
    params.require(:agency).permit(:id, :name, :acronym, :category, :mayoral, :citynet, :address)
  end

end
