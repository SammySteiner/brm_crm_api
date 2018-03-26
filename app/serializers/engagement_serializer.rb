class EngagementSerializer < ActiveModel::Serializer
  attributes :id, :title, :report, :notes, :priority, :start_time, :last_modified_on, :resolved_on, :inc, :ksr, :prj

  belongs_to :service
  belongs_to :engagement_type
  belongs_to :connection
  belongs_to :created_by
  belongs_to :last_modified_by
  has_many :staff_engagements

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
