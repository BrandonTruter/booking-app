class Debtor < ApplicationRecord
  belongs_to :booking
  has_many :patients, class_name: 'Patient'
end
