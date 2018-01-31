class ServiceSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  belongs_to :sdl
  belongs_to :division

  class StaffSerializer < ActiveModel::Serializer
    attributes :id, :fullname, :last_name
  end

  class DivisionSerializer < ActiveModel::Serializer
    attributes :id, :name
  end
end
