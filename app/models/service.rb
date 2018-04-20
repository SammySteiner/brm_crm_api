class Service < ApplicationRecord
  belongs_to :sdl, :class_name => 'Staff', optional: true
  belongs_to :service_owner, :class_name => 'Staff', optional: true
  belongs_to :division, optional: true
  belongs_to :service_category
  has_many :agency_services
  has_many :agencies, through: :agency_services
  has_many :engagements
end
