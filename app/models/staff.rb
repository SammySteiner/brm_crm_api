class Staff < ApplicationRecord
  belongs_to :role
  belongs_to :agency
  has_many :staff_engagement
  has_many :engagements, through: :staff_engagement

  def fullname
    self.first_name + ' ' + self.last_name
  end
end
