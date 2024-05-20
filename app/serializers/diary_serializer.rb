class DiarySerializer < ActiveModel::Serializer
  attributes :id, :name

  belongs_to :entity

  def url
    diary_url(object)
  end
end
