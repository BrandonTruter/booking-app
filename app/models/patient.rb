class Patient < ApplicationRecord
  belongs_to :booking
  has_one :debtor
end
