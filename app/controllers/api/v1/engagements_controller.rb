class Api::V1::EngagementsController < ApplicationController
  # before_action :authorize_user!

  def index
    engagements = Engagement.includes(:service, :engagement_type, :created_by, :last_modified_by, connection: [:arm, :agency]).map do |e|
      {id: e.id, service: e.service.title, type: e.engagement_type.via, arm: {fullname: e.connection.arm.fullname, last_name: e.connection.arm.last_name}, date: e.start_time, title: e.title, agency: {acronym: e.connection.agency.acronym, name: e.connection.agency.name}, priority: e.priority}
    end
    render json: engagements
  end

  def create

  end

  def update

  end

  def destroy

  end

  def show
    e = Engagement.joins(:connection, :engagement_type, :service).find(params[:id])
    render json: e
  end

end
