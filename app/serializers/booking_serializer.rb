class BookingSerializer < ActiveModel::Serializer
  attributes :id, :title, :reason, :status, :booking_type, :start_at, :end_at, :duration

  has_one :debtor
  has_one :patient
  belongs_to :diary
end
