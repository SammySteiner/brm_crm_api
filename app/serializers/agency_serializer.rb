class AgencySerializer < ActiveModel::Serializer
  attributes :id, :name, :acronym, :mayoral

  has_one :arm
  has_one :cio
  has_one :commissioner

  class StaffSerializer < ActiveModel::Serializer
    attributes :id, :fullname, :last_name
  end

end
