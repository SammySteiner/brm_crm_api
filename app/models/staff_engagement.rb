class StaffEngagement < ApplicationRecord
  belongs_to :engagement
  belongs_to :staff
end
