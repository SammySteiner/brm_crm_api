class AgencySerializer < ActiveModel::Serializer
  attributes :id, :name, :acronym

  has_one :arm
  has_one :cio
  has_one :commissioner

  class StaffSerializer < ActiveModel::Serializer
    attributes :fullname, :last_name
  end

end
