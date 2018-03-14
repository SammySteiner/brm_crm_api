class ConnectionSerializer < ActiveModel::Serializer
  attributes :id, :date, :report

  belongs_to :arm
  belongs_to :connection_type
  belongs_to :agency
  has_many :staff, through: :staff_connections
  has_many :engagements


  class AgencySerializer < ActiveModel::Serializer
    attributes :id, :name, :acronym
  end

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
