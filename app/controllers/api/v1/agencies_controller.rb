class Api::V1::AgenciesController < ApplicationController

  def index
    agencies = Agency.includes(:arm, :cio, :commissioner)
    render json: agencies
  end

  def create

  end

  def update

  end

  def destroy
    agency = Agency.find(params[:id])
    agency.destroy
    render json: agency
  end

  def show
    a = Agency.find(params[:id])
    agency_details = {id: a.id, name: a.name, acronym: a.acronym, mayoral: a.mayoral, citynet: a.citynet, address: a.address, commissioner: a.commissioner, cio: a.cio, arm: a.arm}
    render json: agency_details
  end

  private

  def staff_params
    params.require(:agency).permit(:id)
  end

end
