# frozen_string_literal: true

module GxWeb
  module Api
    class Diary
      ENDPOINT = 'api/diary'.freeze
      BASE_URL = 'https://dev_interview.qagoodx.co.za'.freeze
      DEFAULT_SESSION = '0ec10815-b7a6-41df-855e-2899e88d477b'.freeze

      def initialize(session_id: DEFAULT_SESSION, entity_id: 5)
        @session_id = session_id
        @entity_id = entity_id
      end

      def fetch
        url = URI("#{BASE_URL}/#{ENDPOINT}?fields=[
            \"uid\",
            \"entity_uid\",
            \"treating_doctor_uid\",
            \"service_center_uid\",
            \"booking_type_uid\",
            \"name\",
            \"uuid\",
            \"disabled\"
        ]&fields=[
            \"uid\",
            \"entity_uid\",
            \"treating_doctor_uid\",
            \"service_center_uid\",
            \"booking_type_uid\",
            \"name\",
            \"uuid\",
            \"disabled\",
            \"booking_types\",
            \"booking_statuses\"
        ]&filter=[
            \"AND\",
            [
                \"=\",
                [\"I\",\"entity_uid\"],
                [\"L\",#{@entity_id}]
            ]
        ]")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""

        parse_response(https.request(request))
      end

      private

      def parse_response(response)
        puts response.read_body

        json_response = JSON.parse(response.body)

        json_response["data"]
      end
    end
  end
end
