class Engagement < ApplicationRecord
  belongs_to :engagement_type
  has_many :staff_engagement
  has_many :staff, through: :staff_engagement
  has_many :issues
end
