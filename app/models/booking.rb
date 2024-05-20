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

  validates :diary, :reason, :start_time, presence: true

  scope :earliest, -> { reorder(start_time: :asc) }
  scope :latest, -> { reorder(start_time: :desc) }
  scope :daily, -> {
    where(start_time: (Time.now.midnight - 1.day)..Time.now.midnight)
  }
  scope :weekly, -> {
    where(start_time: (7.days.ago)..Time.now.midnight)
  }
  scope :monthly, -> {
    beginning_of_month = Date.today.beginning_of_month
    end_of_month = beginning_of_month.end_of_month
    where(start_time: beginning_of_month..end_of_month)
  }

  def scheduled_at
    self.start_time.to_date
  end

  def daily_appointment
    where(start_time: Date.today.all_day)
  end

  def timestamp
    scheduled_at || daily_appointment
  end
end
