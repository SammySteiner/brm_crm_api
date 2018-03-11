class Api::V1::ConnectionsController < ApplicationController
  before_action :authorize_user!

  def index
    connections = Connection.all
    render json: connections
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show

  end

end
