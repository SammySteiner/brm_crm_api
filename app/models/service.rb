class Service < ApplicationRecord
  belongs_to :sdl, :class_name => 'Staff'
end
