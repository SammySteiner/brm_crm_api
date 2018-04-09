class EngagementSerializer < ActiveModel::Serializer
  attributes :id, :title, :report, :notes, :priority, :start_time, :last_modified_on, :resolved_on, :inc, :ksr, :prj

  belongs_to :service
  belongs_to :engagement_type
  has_many :connections
  belongs_to :created_by
  belongs_to :last_modified_by
  has_many :staff_engagements

  class ConnectionSerializer < ActiveModel::Serializer
    attributes :id, :date, :report, :title

    belongs_to :arm
    belongs_to :connection_type
    belongs_to :agency
    has_many :staff

    class AgencySerializer < ActiveModel::Serializer
      attributes :id, :name, :acronym
    end

    class ConnectionTypeSerializer < ActiveModel::Serializer
      attributes :id, :via
    end

    class StaffSerializer < ActiveModel::Serializer
      attributes :id, :fullname, :last_name
    end

  end

  class StaffEngagementSerializer < ActiveModel::Serializer
    attributes :id
    belongs_to :staff
    class StaffSerializer < ActiveModel::Serializer
      attributes :id, :fullname, :last_name
    end
  end

  class EngagementTypeSerializer < ActiveModel::Serializer
    attributes :id, :via
  end

  class StaffSerializer < ActiveModel::Serializer
    attributes :id, :last_name, :fullname
  end

end
