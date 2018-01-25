class ArmAgency < ApplicationRecord
  belongs_to :arm, :class_name => 'Staff'
  belongs_to :agency
end
