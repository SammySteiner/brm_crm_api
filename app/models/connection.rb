class Connection < ApplicationRecord
  belongs_to :connection_type
  belongs_to :agency
  belongs_to :arm, :class_name => 'Staff'
  has_many :staff_connections
  has_many :staff, through: :staff_connections
  has_many :engagements
  has_many :staff_engagements, through: :engagements

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

  def for_show
    formatted = {
      id: self.id,
      date: self.date,
      notes: self.notes,
      report: self.report,
      connection_type: self.connection_type,
      arm: {id: self.arm.id, fullname: self.arm.fullname},
      agency: {id: self.agency.id, name: self.agency.name, acronym: self.agency.acronym},
      staff_connections: self.staff_connections.map { |sc| {id: sc.staff.id, fullname: sc.staff.fullname} },
      engagements: self.engagements.map do |e|
        {
          id: e.id,
          inc: e.inc,
          ksr: e.ksr,
          prj: e.prj,
          title: e.report,
          notes: e.notes,
          priority: e.priority,
          resolution_notes: e.resolution_notes,
          resolved_on: e.resolved_on,
          service: {id: e.service.id, title: e.service.title},
          created_by: {id: e.created_by.id, fullname: e.created_by.fullname},
          last_modified_by: {id: e.last_modified_by.id, fullname: e.last_modified_by.fullname},
          staff_engagements: e.staff_engagements.map do |se|
            {
              id: se.id,
              staff_id: se.staff.id,
              fullname: se.staff.fullname
            }
          end
        }
      end
    }
  end

  # Use where clause after includes to test if that speeds up the query

end
