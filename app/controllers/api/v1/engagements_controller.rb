class Api::V1::EngagementsController < ApplicationController
  # before_action :authorize_user!

  def index
    engagements = Engagement.includes(:service, :engagement_type, :created_by, :last_modified_by, connection: [:arm, :agency]).map do |e|
      {id: e.id, service: e.service.title, type: e.engagement_type.via, arm: e.connection.arm.fullname, date: e.start_time, title: e.title, agency: e.connection.agency.acronym, priority: e.priority}
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

  end

end
