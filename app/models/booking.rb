# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :diary
  has_one :debtor
  has_one :patient

  AVAILABLE_STATES = [
    'Booked',
    'Arrived',
    'Ready',
    'Treated',
    'Billed',
    'Done'
  ].freeze

  AVAILABLE_TYPES = [
    'Meeting',
    'Follow up',
    'Consultation',
    'Out of office'
  ].freeze

  validates :diary, :reason, :status, :start_at, :booking_type, presence: true
  validates :booking_type, inclusion: { in: AVAILABLE_TYPES }
  validates :status, inclusion: { in: AVAILABLE_STATES }

  scope :earliest, -> { reorder(start_at: :asc) }
  scope :latest, -> { reorder(start_at: :desc) }
  scope :daily, -> {
    where(start_at: (Time.now.midnight - 1.day)..Time.now.midnight)
  }
  scope :weekly, -> {
    where(start_at: (7.days.ago)..Time.now.midnight)
  }
  scope :monthly, -> {
    beginning_of_month = Date.today.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    where(start_at: beginning_of_month..end_of_month)
  }

  def scheduled_at
    self.start_at.to_date
  end

  def daily_appointment
    where(start_at: Date.today.all_day)
  end

  def timestamp
    start_at || end_at
  end
end
