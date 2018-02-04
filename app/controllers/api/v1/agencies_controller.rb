class Api::V1::AgenciesController < ApplicationController

  def index
    agencies = Agency.includes(:arm, :cio, :commissioner)
    render json: agencies
  end

  def create
    agency = Agency.create(agency_params)
    render json: agency
  end

  def update

  end

  def destroy
    agency = Agency.find(params[:id])
    staff = agency.staff
    agency.destroy
    render json: staff
  end

  def show
    a = Agency.find(params[:id])
    agency_details = {id: a.id, name: a.name, acronym: a.acronym, mayoral: a.mayoral, citynet: a.citynet, address: a.address, commissioner: a.commissioner, cio: a.cio, arm: a.arm}
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
