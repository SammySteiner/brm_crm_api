class Api::V1::AgenciesController < ApplicationController

  def index
    agencies = Agency.all
    render json: agencies
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
