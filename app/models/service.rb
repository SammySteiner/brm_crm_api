class Service < ApplicationRecord
  belongs_to :sdl, :class_name => 'Staff', optional: true
  belongs_to :service_owner, :class_name => 'Staff', optional: true
  belongs_to :division, optional: true
end
