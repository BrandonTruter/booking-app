class Debtor < ApplicationRecord
  belongs_to :bookings
  has_many :patients, class_name: 'Patient'
end
