# frozen_string_literal: true

module GxWeb
  class Client
    attr_accessor :session_id

    def initialize(session_id: nil)
      authenticate unless session_id.present?
      @session_id = session_id
    end

    def authenticate
      session_api.login
    end

    def list_diaries
      GxWeb::Api::Diary.new(session_id: session_id).fetch_all
    end

    def list_patients
      GxWeb::Api::Patient.new(session_id: session_id).fetch_all
    end

    def list_debtors
      GxWeb::Api::Debtor.new(session_id: session_id).fetch_all
    end

    def list_bookings(date: "2023-12-01", diary_uid: 5)
      booking_api.fetch(diary_uid: diary_uid, start_time: date)
    end

    def create_booking(payload)
      booking_api.create(payload)
    end

    def update_booking(uid, payload)
      booking_api.update(uid, payload)
    end

    def delete_booking(uid)
      booking_api.delete(uid)
    end

    def list_booking_states
      booking_api.list_status
    end

    def list_booking_types
      booking_api.list_types
    end

    private

    def credentials
      @credentials ||= Rails.application.credentials.gxweb
    end

    def session_id
      @session_id ||= session_api.auth_token
    end

    def session_api
      @session_api ||= GxWeb::Api::Auth.new(credentials)
    end

    def booking_api
      @booking_api ||= GxWeb::Api::Booking.new(session_id: session_id)
    end
  end
end
