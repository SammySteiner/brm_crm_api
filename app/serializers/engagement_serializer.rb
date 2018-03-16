class EngagementSerializer < ActiveModel::Serializer
  attributes :id, :title, :report, :priority, :start_time, :last_modified_on, :resolved_on

  belongs_to :service
  belongs_to :engagement_type
  belongs_to :connection

  class ServiceSerializer < ActiveModel::Serializer
    attributes :id, :title
  end

  class ConnectionSerializer < ActiveModel::Serializer
    attributes :id, :date
    belongs_to :arm
    belongs_to :agency
    class StaffSerializer < ActiveModel::Serializer
      attributes :id, :last_name, :fullname
    end
    class AgencySerializer < ActiveModel::Serializer
      attributes :id, :name, :acronym
    end
  end

end
