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
    engagement = Engagement.find(params[:id])
    engagement.staff_engagements.each do |se|
      se.destroy
    end
    engagement.destroy
    render json: engagement
  end

  def show
    e = Engagement.joins(:connection, :engagement_type, :service).find(params[:id])
    render json: e
  end

  def formInfo
    types = EngagementType.select(:id, :via).map { |t| t.via }
    staff = Staff.all.map { |s| s.fullname }
    services = Service.all.select(:id, :title).map { |s| s.title }
    connections = Connection.all.includes(:arm, :agency, :connection_type).map { |c|  {id: c.id, arm: c.arm.fullname, agency: c.agency.acronym, title: c.title, date: c.date}}
    info = {types: types, staff: staff, services: services, connections: connections}
    render json: info
  end

  private

  def engagement_params
    params.require(:engagement).permit(:id, :date, :report, :notes, :connection_type, :arm, :agency, :engagements => [], :attendees => [])
  end



end
