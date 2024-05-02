class BookingResource < SimpleJSONAPIClient::Base
  COLLECTION_URL = '/bookings'
  INDIVIDUAL_URL = '/bookings/%{id}'
  TYPE = 'bookings'

  attributes :uid, :entity_uid, :title, :booking_type, :booking_state, :booking_date, :duration

  has_one :debtor, class_name: 'Debtor'
  has_one :patient, class_name: 'Patient'
end
