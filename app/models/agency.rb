include ActiveModel::Serialization

class Agency < ApplicationRecord

  has_many :staff
  has_many :connections
  has_one :arm_agency
  has_one :arm, through: :arm_agency
  has_one :cio_agency
  has_one :cio, through: :cio_agency
  has_one :commissioner_agency
  has_one :commissioner, through: :commissioner_agency

  def find_role_id(title)
    Role.find_by(title: title).id
  end

  def find_by_role_id(role)
    person = false
    self.staff.each do |s|
      if s.role_id === role
        person = s
      end
    end
    person
  end

end
