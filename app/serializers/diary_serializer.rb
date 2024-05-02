class DiarySerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :bookings
  belongs_to :entity
end
