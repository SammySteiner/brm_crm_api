class Api::V1::ConnectionsController < ApplicationController
  # before_action :authorize_user!

  def index
    if request.headers[:table].present?
      t = request.headers[:table].intern
      a = request.headers[:attribute].intern
      v = request.headers[:value]
      connections = Connection.includes(:connection_type, :arm, :agency, :engagements, :staff_connections).where(t => {a => v}).map do |c|
        {id: c.id, arm: {fullname: c.arm.fullname, last_name: c.arm.last_name}, date: c.date, report: c.report, agency: {acronym: c.agency.acronym, name: c.agency.name}, engagements: c.engagements.size, type: c.connection_type.via}
      end
    else
      connections = Connection.includes(:connection_type, :arm, :agency, :engagements).map do |c|
        {id: c.id, arm: {fullname: c.arm.fullname, last_name: c.arm.last_name}, date: c.date, report: c.report, agency: {acronym: c.agency.acronym, name: c.agency.name}, engagements: c.engagements.size, type: c.connection_type.via}
      end
    end
    render json: connections
  end

  def create
    type = ConnectionType.find_by(via: connection_params[:connection_type])
    fullname = connection_params[:arm].split(" ")
    first_name = fullname[0]
    last_name = fullname[1]
    arm = Staff.find_by(first_name: first_name, last_name: last_name)
    agency = Agency.find_by(name: connection_params[:agency])
    date = Time.parse(connection_params[:date])
    connection = Connection.create(date: date, report: connection_params[:report], notes: connection_params[:notes], connection_type: type, arm: arm, agency: agency)
    connection_params[:attendees].each do |a|
      StaffConnection.create(staff: Staff.find(a), connection: connection)
    end
    connection_params[:engagements].each do |e|
      ConnectionEngagement.create(connection: connection, engagement: Engagement.find(e))
    end
    render json: connection.for_show
  end

  def update
    type = ConnectionType.find_by(via: connection_params[:connection_type])
    fullname = connection_params[:arm].split(" ")
    first_name = fullname[0]
    last_name = fullname[1]
    arm = Staff.find_by(first_name: first_name, last_name: last_name)
    agency = Agency.find_by(name: connection_params[:agency])
    date = Time.parse(connection_params[:date])
    connection = Connection.find(connection_params[:id])
    connection.update(date: date, report: connection_params[:report], notes: connection_params[:notes], connection_type: type, arm: arm, agency: agency)
    connection_params[:attendees].each do |a|
      StaffConnection.find_or_create_by(staff: Staff.find(a), connection: connection)
    end
    removed_staff = connection.staff.map { |s| s.id } - connection_params[:attendees]
    removed_staff.each do |rs|
      StaffConnection.find_by(staff: Staff.find(rs), connection: connection).destroy
    end
    connection_params[:engagements].each do |e|
      ConnectionEngagement.find_or_create_by(connection: connection, engagement: Engagement.find(e))
    end
    removed_engagements = connection.engagements.map { |e| e.id } - connection_params[:engagements]
    removed_engagements.each { |e| ConnectionEngagement.find_by(connection: connection, engagement: Engagement.find(e)).destroy }
    render json: connection.for_show
  end

  def destroy
    connection = Connection.find(params[:id])
    connection.staff_connections.each do |sc|
      sc.destroy
    end
    connection.engagements.each do |e|
      if e.connections.size === 1
        e.staff_engagements.each do |se|
          se.destroy
        end
        e.destroy
      end
    end
    connection.connection_engagements.each do |ce|
      ce.destroy
    end
    connection.destroy
    render json: connection
  end

  def show
    c = Connection.find(params[:id])
    connection_details = c.for_show
    render json: connection_details
  end

  def formInfo
    types = ConnectionType.select(:id, :via).map { |t| t.via }
    arms = Staff.where(role: Role.find_by(title: "ARM")).map { |arm|  arm.fullname }
    agencies = Agency.select(:id, :name, :acronym).map { |a|  {name: a.name, acronym: a.acronym}}
    staff = Staff.all.map { |s| {id: s.id, fullname: s.fullname} }
    agency_engagements = Engagement.includes(:service, :engagement_type, :connections => [:agency]).map { |e| {title: e.title, id: e.id} }
    info = {types: types, arms: arms, agencies: agencies, staff: staff, agency_engagements: agency_engagements}
    render json: info
  end

  private

  def connection_params
    params.require(:connection).permit(:id, :date, :report, :notes, :connection_type, :arm, :agency, :engagements => [], :attendees => [])
  end

end
