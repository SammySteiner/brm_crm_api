class Division < ApplicationRecord
  has_many :services
  belongs_to :deputy_commissioner, :class_name => 'Staff'
end
