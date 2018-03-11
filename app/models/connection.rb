class Connection < ApplicationRecord
  belongs_to :connection_type
  belongs_to :arm, :class_name => 'Staff'
  has_many :staff_connections
  has_many :staff, through: :staff_connections
  has_many :engagements

  def agencies
    agencies = []
    self.engagements.each do |e|
      e.staff_engagements.includes(:staff).each do |se|
        agency = se.staff.agency
        if !(agency.name === 'INFORMATION TECHNOLOGY AND TELECOMMUNICATIONS, DEPARTMENT OF')
          agencies.push(agency)
        end
      end
    end
    agencies
  end

  # Use where clause after includes to test if that speeds up the query

end
