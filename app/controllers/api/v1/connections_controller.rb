class Api::V1::ConnectionsController < ApplicationController
  # before_action :authorize_user!

  def index
    connections = Connection.includes(:connection_type, :arm, :agency, :engagements).map do |c|
      {id: c.id, arm: {fullname: c.arm.fullname, last_name: c.arm.last_name}, date: c.date, report: c.report, agency: {acronym: c.agency.acronym, name: c.agency.name}, engagements: c.engagements.size, type: c.connection_type.via}
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
      fullname = a.split(" ")
      first_name = fullname[0]
      last_name = fullname[1]
      StaffConnection.create(staff: Staff.find_by(first_name: first_name, last_name: last_name), connection: connection)
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
    staff = connection.staff_connections.map { |sc| sc.staff.fullname }
    new_staff = []
    connection_params[:attendees].each do |a|
      fullname = a.split(" ")
      first_name = fullname[0]
      last_name = fullname[1]
      sc = StaffConnection.find_or_create_by(staff: Staff.find_by(first_name: first_name, last_name: last_name), connection: connection)
      new_staff << sc.staff.fullname
    end
    removed_staff = staff - new_staff
    if removed_staff.present?
      removed_staff.each do |rs|
        fullname = rs.split(" ")
        first_name = fullname[0]
        last_name = fullname[1]
        s = Staff.find_by(first_name: first_name, last_name: last_name)
        connection.staff_connections.where(staff: s)[0].destroy
      end
    end
    render json: connection.for_show
  end

  def destroy
    connection = Connection.find(params[:id])
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
    agencies = Agency.select(:id, :name).map { |a|  a.name}
    staff = Staff.all.map { |s| s.fullname }
    info = {types: types, arms: arms, agencies: agencies, staff: staff}
    render json: info
  end

  private

  def connection_params
    params.require(:connection).permit(:id, :date, :report, :notes, :connection_type, :arm, :agency, :engagements => [], :attendees => [])
  end

end
