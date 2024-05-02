class PatientResource < SimpleJSONAPIClient::Base
  COLLECTION_URL = '/patients'
  INDIVIDUAL_URL = '/patients/%{id}'
  TYPE = 'patients'

  attributes :uid, :entity_uid, :name, :surname, :initials, :title, :email

  has_one :debtor, class_name: 'Debtor'
end
