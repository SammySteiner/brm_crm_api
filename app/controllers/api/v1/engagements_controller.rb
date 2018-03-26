class Api::V1::EngagementsController < ApplicationController
  # before_action :authorize_user!

  def index
    engagements = Engagement.includes(:service, :engagement_type, :created_by, :last_modified_by, connection: [:arm, :agency]).map do |e|
      {id: e.id, service: e.service.title, type: e.engagement_type.via, arm: {fullname: e.connection.arm.fullname, last_name: e.connection.arm.last_name}, date: e.start_time, title: e.title, agency: {acronym: e.connection.agency.acronym, name: e.connection.agency.name}, priority: e.priority}
    end
    render json: engagements
  end

  def create
    type = EngagementType.find_by(via: engagement_params[:type])
    connection = Connection.find(engagement_params[:connection])
    service = Service.find_by(title: engagement_params[:service])
    user = Staff.find_by(email: current_user.email)
    if engagement_params[:resolved_on].present?
      resolved_on = Time.parse(engagement_params[:resolved_on])
    else
      resolved_on = nil
    end
    engagement = Engagement.create(
    title: engagement_params[:title],
    report: engagement_params[:report],
    notes: engagement_params[:notes],
    ksr: engagement_params[:ksr],
    inc: engagement_params[:inc],
    prj: engagement_params[:prj],
    priority: engagement_params[:priority],
    start_time: Time.parse(engagement_params[:start_time]),
    resolved_on: resolved_on,
    service: service,
    engagement_type: type,
    connection: connection,
    created_by: user,
    last_modified_by: user,
    )
    engagement_params[:team].each do |t|
      fullname = t.split(" ")
      first_name = fullname[0]
      last_name = fullname[1]
      StaffEngagement.create(staff: Staff.find_by(first_name: first_name, last_name: last_name), engagement: engagement)
    end
    render json: engagement
  end

  def update
    type = EngagementType.find_by(via: engagement_params[:type])
    connection = Connection.find(engagement_params[:connection])
    service = Service.find_by(title: engagement_params[:service])
    user = Staff.find_by(email: current_user.email)
    if engagement_params[:resolved_on].present?
      resolved_on = Time.parse(engagement_params[:resolved_on])
    else
      resolved_on = nil
    end
    engagement = Engagement.find(engagement_params[:id])
    engagement.update(
    title: engagement_params[:title],
    report: engagement_params[:report],
    notes: engagement_params[:notes],
    ksr: engagement_params[:ksr],
    inc: engagement_params[:inc],
    prj: engagement_params[:prj],
    priority: engagement_params[:priority],
    start_time: Time.parse(engagement_params[:start_time]),
    resolved_on: resolved_on,
    service: service,
    engagement_type: type,
    connection: connection,
    last_modified_by: user,
    )
    staff = engagement.staff_engagements.map { |se| se.staff.fullname }
    new_staff = []
    engagement_params[:team].each do |t|
      fullname = t.split(" ")
      first_name = fullname[0]
      last_name = fullname[1]
      se = StaffEngagement.find_or_create_by(staff: Staff.find_by(first_name: first_name, last_name: last_name), engagement: engagement)
      new_staff << se.staff.fullname
    end
    removed_staff = staff - new_staff
    if removed_staff.present?
      removed_staff.each do |rs|
        fullname = rs.split(" ")
        first_name = fullname[0]
        last_name = fullname[1]
        s = Staff.find_by(first_name: first_name, last_name: last_name)
        engagement.staff_engagements.where(staff: s)[0].destroy
      end
    end
    render json: engagement
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
    if Engagement.exists?(params[:id])
      e = Engagement.joins(:connection, :engagement_type, :service).find(params[:id])
      render json: e
    else
      render json: {error: "Page no longer exits."}
    end
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
    params.require(:engagement).permit(:id, :title, :report, :notes, :ksr, :inc, :prj, :priority, :service, :start_time, :resolved_on, :type, :connection, :team => [])
  end



end
