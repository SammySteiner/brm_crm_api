class EngagementSerializer < ActiveModel::Serializer
  attributes :id, :agencies, :service, :created_by_id
end
