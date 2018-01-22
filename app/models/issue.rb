class Issue < ApplicationRecord
  belongs_to :agency
  belongs_to :service
  belongs_to :engagement
  belongs_to :created_by, :class_name => 'Staff'
  belongs_to :last_modified_by, :class_name => 'Staff'
end
