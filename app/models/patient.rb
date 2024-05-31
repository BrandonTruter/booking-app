class Patient < ApplicationRecord
  belongs_to :booking, dependent: :destroy
  has_one :debtor
end
