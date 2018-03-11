class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :date, :notes, :agencies

  belongs_to :connection_type
  has_many :staff, through: :staff_connections
  has_many :engagements

  class ConnectionTypeSerializer < ActiveModel::Serializer
    attributes :id, :via
  end

  class StaffSerializer < ActiveModel::Serializer
    attributes :id, :fullname, :last_name
  end

  class EngagementSerializer < ActiveModel::Serializer
    attributes :id, :title
  end


end
