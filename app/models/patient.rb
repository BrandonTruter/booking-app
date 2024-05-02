class Patient < ApplicationRecord
  belongs_to :bookings
  has_one :debtor
end
