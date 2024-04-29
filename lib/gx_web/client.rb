module GxWeb
  class Client
    def initialize(session_id)
      @session_id = session_id
    end

    def login(username, password)
      # API::Auth.new(payload)
      process_request(:login, {username: username, password: password})
    end

    def list_diaries
      GxWeb::Api::Diary.new(@session_id)
      # process_request(:diary, {})
    end

    def list_bookings(entity_id, diary_id)
      process_request(:booking, {entity_id: entity_id, diary_id: diary_id})
    end

    private

    def process_request(endpoint, payload)
      case endpoint
      when :login then GxWeb::Api::Auth.new(payload)
      when :diary then GxWeb::Api::Diary.new(payload)
      when :booking then GxWeb::Api::Booking.new(payload)
      else
        raise InvalidEndpointError.new("Unsupported API: #{endpoint}")
      end
    end

    class InvalidEndpointError < StandardError; end
  end
end
