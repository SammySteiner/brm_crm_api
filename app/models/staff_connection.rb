class StaffConnection < ApplicationRecord
  belongs_to :connection
  belongs_to :staff
end
