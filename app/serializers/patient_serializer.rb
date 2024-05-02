class PatientSerializer < ActiveModel::Serializer
  attributes :id, :uid, :name

  has_one :debtor
  belongs_to :booking
end
