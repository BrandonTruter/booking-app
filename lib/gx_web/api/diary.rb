module GxWeb
  module Api
    class Diary
      BASE_URL = 'https://dev_interview.qagoodx.co.za'
      ENDPOINT = 'api/diary'

      def initialize(entity_id, session_id)
        puts "DIARIES API"

        url = URI("https://dev_interview.qagoodx.co.za/api/diary?fields=[
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
                [\"L\",#{entity_id}]
            ]
        ]")

        https = Net::HTTP.new(url.host, url.port)
        https.use_ssl = true
        response = https.get(url, {'Cookie' => "session_id=#{token}"})

        parse_response(response)
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
