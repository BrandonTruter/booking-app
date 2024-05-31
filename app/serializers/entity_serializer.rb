class EntitySerializer < ActiveModel::Serializer
  attributes :id, :username, :token

  has_many :diaries
end
