include ActiveModel::Serialization

class Staff < ApplicationRecord

  belongs_to :role
  belongs_to :agency
  has_many :arm_agencies
  has_many :staff_engagement
  has_many :engagements, through: :staff_engagement
  has_many :services

  def fullname
    self.first_name + ' ' + self.last_name
  end

  def assignments
    arms_agecies = ArmAgency.where(arm_id:self.id)
    arms_agecies.map do |aa|
      aa.agency
    end
  end

end
