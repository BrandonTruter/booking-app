class Diary < ApplicationRecord
  belongs_to :entity
  has_many :bookings
end
