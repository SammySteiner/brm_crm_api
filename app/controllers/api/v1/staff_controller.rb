class Api::V1::StaffController < ApplicationController

  def index
    staff = Staff.all
    render json: staff
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
