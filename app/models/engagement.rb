class Engagement < ApplicationRecord
  belongs_to :service
  has_many :connection_engagements
  has_many :connections, through: :connection_engagements
  belongs_to :engagement_type
  has_many :staff_engagements
  has_many :staff, through: :staff_engagements
  belongs_to :created_by, :class_name => 'Staff'
  belongs_to :last_modified_by, :class_name => 'Staff'

  def title
    self.connections[0].agency.acronym + ' ' + self.engagement_type.via + ' with ' + self.service.title
  end

  def arm
    {fullname: self.connections[0].arm.fullname, last_name: self.connections[0].arm.last_name}
  end

  def agency
    {name: self.connections[0].agency.name, acronym: self.connections[0].agency.acronym}
  end


  # def agencies
  #   self.staff_engagements.includes(:staff).map do |se|
  #     se.staff.agency.name
  #   end.uniq
  # end

end
