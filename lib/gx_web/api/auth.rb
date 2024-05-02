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
        auth_session
      end

      private

      def auth_session
        url = URI("#{@credentials.base_url}/api/session")
        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        request = Net::HTTP::Post.new(url)
        request.body = auth_body(credentials.username, credentials.password)

        response = https.request(request)
        parse_response(response)
      end

      def auth_body(user, pass)
        JSON.dump({
          "model": {
            "timeout": TIMEOUT
          },
          "auth": [
            [
              "password",
              {
                "username": user,
                "password": pass
              }
            ]
          ]
        })
      end

      def parse_response(response)
        response = JSON.parse(response.body)
        uid_token = response["data"]["uid"]
        username = @credentials.username
        @auth_token = uid_token
        @entity = Entity.find_by(username: username, password: @credentials.password)

        if @entity.present?
          @entity.token = uid_token
          @entity.save!
        end

        _token_cookie = HTTP::Cookie.new("uid", uid_token, domain: 'localhost:3000', for_domain: true, path: '/api/v1')
        _session_cookie = HTTP::Cookie.new("session_id", "\"\\\"#{uid_token}\\\"_#{username}\"")
        response
      end
    end
  end
end
