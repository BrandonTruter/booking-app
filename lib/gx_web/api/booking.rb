module GxWeb::Api
  class Booking
    def initialize(payload={})
      @payload = payload
    end

    def find_booking(diary_uid: 5, start_time: "2023-12-01")
      url = URI("https://dev_interview.qagoodx.co.za/api/booking?fields=[
          \"uid\",
          \"entity_uid\",
          \"diary_uid\",
          \"booking_type_uid\",
          \"booking_status_uid\",
          \"patient_uid\",
          \"start_time\",
          \"duration\",
          \"treating_doctor_uid\",
          \"reason\",
          \"invoice_nr\",
          \"cancelled\",
          \"uuid\"
      ]&filter=[ \"AND\", [ \"=\", [\"I\",\"diary_uid\"], [\"L\",#{diary_uid}] ], [ \"=\", [ \"::\", [\"I\",\"start_time\"], [\"I\",\"date\"] ], [\"L\",\"#{start_time}\"] ] ]
      ")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer d6c9c711-78c1-491f-bd27-3b43fd212185"
      request["Cookie"] = "session_id=\"\\\"0ec10815-b7a6-41df-855e-2899e88d477b\\\"_applicant_005\""

      booking_request = https.request(request)

      response = JSON.parse(booking_request.body)

      return response unless response["status"] == "OK"

      response["data"].map {|d| {
        uid: d["uid"], uuid: d["uuid"], booking_type_uid: d["booking_type_uid"],
        start_time: d["start_time"], duration: d["duration"], reason: d["reason"]
      }}
    end

    def create_booking
      url = URI("https://dev_interview.qagoodx.co.za/api/booking")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Cookie"] = "session_id=\"\\\"0ec10815-b7a6-41df-855e-2899e88d477b\\\"_applicant_005\""
      request.body = JSON.dump({
        "model": {
          "entity_uid": 5,
          "diary_uid": 5,
          "booking_type_uid": 21,
          "booking_status_uid": 27,
          "start_time": "2023-12-01T08:00:00",
          "duration": 15,
          "patient_uid": 15,
          "reason": "Cool example reason here",
          "cancelled": false
        }
      })

      response = https.request(request)
      parse_response(response)
    end

    def update_booking(uid)
      url = URI("https://dev_interview.qagoodx.co.za/api/booking/#{uid}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Content-Type"] = "application/json"
      request["Cookie"] = "session_id=\"\\\"0ec10815-b7a6-41df-855e-2899e88d477b\\\"_applicant_005\""
      request.body = JSON.dump({
        "model": {
          "uid": uid,
          "start_time": "2023-12-01T09:00:00",
          "duration": 50,
          "patient_uid": 15,
          "reason": "Updated this booking"
        }
      })

      response = https.request(request)
      parse_response(response)
    end

    private

    def parse_response(res)
      puts res.read_body

      response = JSON.parse(res.body)

      return response unless response["status"] == "OK"

      response["data"]["uid"]
    end
  end
end
