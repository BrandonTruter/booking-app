# frozen_string_literal: true

class BookingType < ApplicationRecord
  belongs_to :bookable, polymorphic: true
  belongs_to :booking, foreign_key: "booking_uid", optional: true
  has_and_belongs_to_many :diaries, foreign_key: "diary_uid", optional: true

  TYPES_OF_BOOKINGS = [ 'Meeting', 'Follow up', 'Consultation', 'Out of office' ].freeze
end
