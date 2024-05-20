class Debtor < ApplicationRecord
  belongs_to :booking, dependent: :destroy
  has_many :patients, class_name: 'Patient'
end
