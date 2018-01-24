class Service < ApplicationRecord
  belongs_to :sdl, :class_name => 'Staff'
  belongs_to :division
end
