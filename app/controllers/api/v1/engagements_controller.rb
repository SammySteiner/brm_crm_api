class Api::V1::EngagementsController < ApplicationController
  # before_action :authorize_user!

  def index
    if request.headers[:table].present?
      t = request.headers[:table].intern
      a = request.headers[:attribute].intern
      v = request.headers[:value]
      engagements = Engagement.includes(:service, :engagement_type, :created_by, :last_modified_by, connections: [:arm, :agency]).where(:connections => {t => {a => v}}).map do |e|
        {id: e.id, service: e.service.title, type: e.engagement_type.via, arm: e.arm, date: e.start_time, title: e.title, agency: e.agency, priority: e.priority, resolved_on: e.resolved_on, report: e.report}
      end
    else
      engagements = Engagement.includes(:service, :engagement_type, :created_by, :last_modified_by, connections: [:arm, :agency]).map do |e|
        {id: e.id, service: e.service.title, type: e.engagement_type.via, arm: e.arm, date: e.start_time, title: e.title, agency: e.agency, priority: e.priority, resolved_on: e.resolved_on, report: e.report}
      end
    end
    render json: engagements
  end

  def create
    type = EngagementType.find_by(via: engagement_params[:type])
    service = Service.find_by(title: engagement_params[:service])
    user = Staff.find_by(email: current_user.email)
    if engagement_params[:resolved_on].present?
      resolved_on = Time.parse(engagement_params[:resolved_on])
    else
      resolved_on = nil
    end
    engagement = Engagement.create(
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
    created_by: user,
    last_modified_by: user,
    )
    engagement_params[:connections].each do |c|
      ConnectionEngagement.create(connection: Connection.find(c), engagement: engagement)
    end
    engagement_params[:team].each do |t|
      StaffEngagement.create(staff: Staff.find(t), engagement: engagement)
    end
    render json: engagement
  end

  def update
    type = EngagementType.find_by(via: engagement_params[:type])
    service = Service.find_by(title: engagement_params[:service])
    user = Staff.find_by(email: current_user.email)
    if engagement_params[:resolved_on].present?
      resolved_on = Time.parse(engagement_params[:resolved_on])
    else
      resolved_on = nil
    end
    engagement = Engagement.find(engagement_params[:id])
    engagement.update(
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
    last_modified_by: user,
    )
    engagement_params[:team].each do |t|
      se = StaffEngagement.find_or_create_by(staff: Staff.find(t), engagement: engagement)
    end
    removed_staff = engagement.staff.map { |s| s.id } - engagement_params[:team]
    removed_staff.each do |s|
      StaffEngagement.find_by(staff: Staff.find(s), engagement: engagement).destroy
    end
    engagement_params[:connections].each do |c|
      ConnectionEngagement.find_or_create_by(connection: Connection.find(c), engagement: engagement)
    end
    connections_to_remove = engagement.connections.map { |c| c.id } - engagement_params[:connections]
    connections_to_remove.each { |c| ConnectionEngagement.find_by(connection: Connection.find(c), engagement: engagement).destroy }
    render json: engagement
  end

  def destroy
    engagement = Engagement.find(params[:id])
    engagement.connection_engagements.each do |ce|
      ce.destroy
    end
    engagement.staff_engagements.each do |se|
      se.destroy
    end
    engagement.destroy
    render json: engagement
  end

  def show
    if Engagement.exists?(params[:id])
      e = Engagement.joins(:connections, :engagement_type, :service).find (params[:id])
      render json: e
    else
      render json: {error: "Page no longer exits."}
    end
  end

  def formInfo
    types = EngagementType.select(:id, :via).map { |t| t.via }
    staff = Staff.all.map { |s| {id: s.id, fullname: s.fullname} }
    services = Service.all.select(:id, :title).map { |s| s.title }
    connections = Connection.all.includes(:arm, :agency, :connection_type).map { |c|  {id: c.id, arm: c.arm.fullname, agency: c.agency.acronym, title: c.title, date: c.date}}
    info = {types: types, staff: staff, services: services, connections_list: connections}
    render json: info
  end

  private

  def engagement_params
    params.require(:engagement).permit(:id, :report, :notes, :ksr, :inc, :prj, :priority, :service, :start_time, :resolved_on, :type, :connections => [], :team => [])
  end



end
