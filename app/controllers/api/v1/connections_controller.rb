class Api::V1::ConnectionsController < ApplicationController
  # before_action :authorize_user!

  def index
    connections = Connection.includes(:connection_type, :arm, :agency, :engagements).map do |c|
      {id: c.id, arm: {fullname: c.arm.fullname, last_name: c.arm.last_name}, date: c.date, report: c.report, agency: {acronym: c.agency.acronym, name: c.agency.name}, engagements: c.engagements.size, type: c.connection_type.via}
    end
    render json: connections
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show
    c = Connection.find(params[:id])
    connection_details = c.for_show
    render json: connection_details
  end

end
