class Staff < ApplicationRecord
  belongs_to :role
  has_one :staff_agency
  has_one :agency, through: :staff_agency
  has_many :staff_engagement
  has_many :engagements, through: :staff_engagement
end
