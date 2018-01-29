class StaffSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :fullname, :office_phone, :email, :assignments

  belongs_to :agency
  belongs_to :role

  class AgencySerializer < ActiveModel::Serializer
    attributes :name, :acronym
  end

end
