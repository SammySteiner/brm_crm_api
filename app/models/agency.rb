class Agency < ApplicationRecord
  has_many :staff
  has_one :arm_agency
  has_one :arm, through: :arm_agency



  def cio
    cio_id = find_role_id("CIO")
    find_by_role_id(cio_id)
  end

  def comissioner
    commissioner_id = find_role_id("Commissioner")
    find_by_role_id(commissioner_id)
  end

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
