class StaffSerializer < ActiveModel::Serializer
  attributes :id, :last_name, :fullname, :office_phone, :email

  belongs_to :agency
  belongs_to :role

  class AgencySerializer < ActiveModel::Serializer
    attributes :id, :name, :acronym
  end

  class RoleSerializer < ActiveModel::Serializer
    attributes :title
  end

end
