class CioAgency < ApplicationRecord
  belongs_to :cio, :class_name => 'Staff'
  belongs_to :agency
end
