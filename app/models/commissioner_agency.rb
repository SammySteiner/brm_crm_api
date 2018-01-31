class CommissionerAgency < ApplicationRecord
  belongs_to :commissioner, :class_name => 'Staff'

  belongs_to :agency
end
