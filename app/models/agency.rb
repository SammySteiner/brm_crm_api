class Agency < ApplicationRecord
  has_many :staff_agency
  has_many :staff, through: :staff_agency
  belongs_to :cio, :class_name => 'Staff'
  belongs_to :arm, :class_name => 'Staff'
  belongs_to :commissioner, :class_name => 'Staff'
end
