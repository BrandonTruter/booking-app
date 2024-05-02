class DebtorResource < SimpleJSONAPIClient::Base
  COLLECTION_URL = '/debtors'
  INDIVIDUAL_URL = '/debtors/%{id}'
  TYPE = 'debtors'

  attributes :uid, :entity_uid, :name, :surname

  has_many :patients, class_name: 'Patient'
end
