# frozen_string_literal: true

module GxWeb
  module Api
    class Auth
      TIMEOUT = 259200
      attr_reader :auth_token
      attr_reader :credentials

      def initialize(credentials)
        @credentials = credentials
      end

      def login
        response = auth_session

        if response.success?
          auth_response = response.body["data"]
          @auth_token = auth_response["uid"]
          @entity = Entity.find_by(username: credentials.username, password: credentials.password)
          @entity.update!(token: @auth_token) if @entity.present?

          HTTP::Cookie.new("session_id", "\"\\\"#{@auth_token}\\\"_#{credentials.username}\"")
          HTTP::Cookie.new("token", @auth_token, for_domain: true, path: '/')
        end

        self
      end

      private

      def auth_session
        # begin
        conn = Faraday.new(credentials.base_url) do |config|
          config.request :json
          config.response :json
          config.response :raise_error
          config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
        end

        conn.post('/api/session') do |req|
          req.headers[:content_type] = 'application/json'
          req.body = JSON.generate({
            model: {
              timeout: 259200
            },
            auth: [
              [
                "password", {
                  username: credentials.username,
                  password: credentials.password
                }
              ]
            ]
          })
        end
      end
    end
  end
end
