class DebtorSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name

  has_many :patients
  belongs_to :booking
end
