# frozen_string_literal: true

module GxWeb::Api
  class Patient
    ENDPOINT = 'api/patient'.freeze
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
				\"debtor_uid\",
				\"name\",
				\"surname\",
				\"initials\",
				\"title\"
			]&filter=[
				\"=\",
				[\"I\", \"entity_uid\"],
				[\"L\", #{@entity_uid}]
			]&limit=100")

			https = Net::HTTP.new(url.host, url.port)
			https.use_ssl = true

			request = Net::HTTP::Get.new(url)
			request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""

			response = https.request(request)
			puts response.read_body

			resp = JSON.parse(response.body)

			resp["data"]
		end
  end
end
