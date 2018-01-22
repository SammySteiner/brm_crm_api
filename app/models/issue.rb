class Issue < ApplicationRecord
  belongs_to :agency
  belongs_to :service
  belongs_to :engagement
end
