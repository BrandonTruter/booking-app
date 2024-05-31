# frozen_string_literal: true

module GxWeb
  class Request
    attr_reader :entity_id, :session_id
    attr_accessor :payload, :access_token, :connection
    DEFAULT_SESSION = '0ec10815-b7a6-41df-855e-2899e88d477b'.freeze

    def initialize(session_id: DEFAULT_SESSION, entity_id: 5, payload: {})
      @session_id = session_id
      @entity_id = entity_id
      @payload = payload
      @connection = connection
    end

    def goodx_request(http_method: :get, endpoint: 'api/diary', params: {})
      connection.set_basic_auth credentials.username, credentials.password
      default_headers.each { |key, value| connection.headers[key] = value }
      connection.headers['Cookie'] = "session_id=\"\\\"#{session_id}\\\"_applicant_005\""

      response = build_request(http_method, endpoint)

      handle_response(response)
    end

    private

    def handle_response(response)
      Rails.logger.debug("[GxWeb::Response] [#{response.body}]")

      if response.success?
        response.body["data"]
      else
        {
          error_code: response.status,
          error_message: response.body
        }
      end
    end

    def build_request(http_method, endpoint)
      case http_method
      when :get then get_request(endpoint)
      when :put then put_request(endpoint)
      when :post then post_request(endpoint)
      when :delete then delete_request(endpoint)
      else
        raise HttpMethodError.new("invalid HTTP method: #{http_method}")
      end
    end

    def get_request(path)
      connection.get(path) do |req|
        req.options.params_encoder = Faraday::FlatParamsEncoder
      end
    end

    def put_request(path)
      connection.put(path)
    end

    def post_request(path)
      connection.post(path)
    end

    def delete_request(path)
      connection.delete(path)
    end

    def include_body?(method)
      [:post, :put].include?(method) && payload.present?
    end

    def api_error(status: 500, message: "invalid request")
      { status: status, error: message }
    end

    def credentials
      @credentials ||= Rails.application.credentials.gxweb
    end

    def connection
      @connection ||= Faraday.new(credentials.base_url) do |config|
        config.request :json
        config.response :json
        config.response :raise_error
        config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
      end
    end

    def default_headers
      @_headers ||= {
        'Authorization': "Token #{session_id}",
        'Content-Type': 'application/json'
      }
    end

    def auth_token
      Rails.cache.fetch(:authorization_token, expires_in: 1.hour, race_condition_ttl: 1.hour) do
        Rails.logger.debug('[GxWeb::Request] Fetching a new token')
        authenticate
      end
    end

    def auth_header
      return "Bearer #{auth_token}" if @access_token.present?

      "Basic #{Base64.strict_encode64("#{credentials.username}:#{credentials.password}")}"
    end

    def auth_session
      @payload = auth_payload
      goodx_request(
        http_method: :post,
        endpoint: 'api/session'
      )
    end

    def auth_payload
      JSON.dump({
        "model": {
          "timeout": 259200
        },
        "auth": [
          [
            "password",
            {
              "username": credentials.username,
              "password": credentials.password
            }
          ]
        ]
      })
    end

    def authenticate
      response = auth_session

      if response.key?('data')
        @access_token = response["data"]["uid"]
        session[:token] = @access_token
      end
    end

    class HttpMethodError < ::StandardError; end
  end
end
