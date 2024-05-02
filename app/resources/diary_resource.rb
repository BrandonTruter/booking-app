class DiaryResource < SimpleJSONAPIClient::Base
  COLLECTION_URL = '/diaries'
  INDIVIDUAL_URL = '/diaries/%{id}'
  TYPE = 'diaries'

  attributes :uid, :uuid, :name, :disabled

  has_many :bookings, class_name: 'Booking'
end