class Api::V1::ConnectionsController < ApplicationController
  # before_action :authorize_user!

  def index
    connections = Connection.includes(:connection_type, :staff, :arm, :staff_connections, :agency, :engagements)
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
