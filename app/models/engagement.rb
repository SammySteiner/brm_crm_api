class Engagement < ApplicationRecord
  belongs_to :service
  belongs_to :connection
  belongs_to :engagement_type
  has_many :staff_engagements
  belongs_to :created_by, :class_name => 'Staff'
  belongs_to :last_modified_by, :class_name => 'Staff'

  def agencies
    self.staff_engagements.includes(:staff).map do |se|
      se.staff.agency.name
    end.uniq
  end

end
