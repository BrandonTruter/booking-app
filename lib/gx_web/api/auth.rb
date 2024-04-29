require "uri"
require "json"
require "net/http"

module GxWeb
  module Api
    class Auth
      BASE_URL = 'https://dev_interview.qagoodx.co.za'
      DEFAULT_TIMEOUT = 120

      attr_reader :session_id

      def initialize(payload)
        puts "SESSION API"
        gxweb_session_id(payload)
      end

      private

      def gxweb_session_id(payload)
        url = URI("#{BASE_URL}/api/session")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = "application/json"
        request.body = build_auth_body(payload)

        response = https.request(request)
        puts response.read_body
        parse_response(response)
      end

      def build_auth_body(payload)
        JSON.dump({
          "model": {
            "timeout": DEFAULT_TIMEOUT
          },
          "auth": [
            [
              "password",
              {
                "username": payload[:username],
                "password": payload[:password]
              }
            ]
          ]
        })
      end

      def parse_response(response)
        session_response = JSON.parse(response.body)

        @session_id = session_response["data"]["uid"]
        @session_id
      end
    end
  end
end
