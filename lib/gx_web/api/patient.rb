module GxWeb::Api
  class Patient
		def initialize(entity_uid, session_id)
			url = URI("https://dev_interview.qagoodx.co.za/api/patient?fields=[
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
				[\"L\", #{entity_uid}]
			]&limit=100")

			https = Net::HTTP.new(url.host, url.port)
			https.use_ssl = true

			request = Net::HTTP::Get.new(url)
			request["Cookie"] = "session_id=\"\\\"#{session_id}\\\"_applicant_005\""

			response = https.request(request)
			puts response.read_body

			resp = JSON.parse(response.body)

			resp["data"]
		end
  end
end
