module GxWeb
  class Client
    def initialize
      authenticate
    end

    def authenticate
      session_api.login
    end

    def list_diaries
      diary_api.fetch
    end

    def list_patients
      patient_api.fetch
    end

    def list_debtors
      debtor_api.fetch
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

    def session_api
      @session_api ||= GxWeb::Api::Auth.new(credentials)
    end

    def diary_api
      diary_api ||= GxWeb::Api::Diary.new(session_id: @session_api.auth_token)
    end

    def booking_api
      @booking_api ||= GxWeb::Api::Booking.new(session_id: @session_api.auth_token)
    end

    def debtor_api
      @debtor_api ||= GxWeb::Api::Debtor.new(session_id: @session_api.auth_token)
    end

    def patient_api
      @patient_api ||= GxWeb::Api::Paitent.new(session_id: @session_api.auth_token)
    end
  end
end
