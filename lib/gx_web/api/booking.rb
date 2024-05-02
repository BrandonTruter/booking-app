# frozen_string_literal: true

module GxWeb::Api
  class Booking
    ENDPOINT = 'api/booking'.freeze
    BASE_URL = 'https://dev_interview.qagoodx.co.za'.freeze
    DEFAULT_SESSION = '0ec10815-b7a6-41df-855e-2899e88d477b'.freeze

    def initialize(session_id: DEFAULT_SESSION, entity_id: 5)
      @session_id = session_id
      @entity_id = entity_id
    end

    def fetch(diary_uid: 5, start_time: "2023-12-01")
      url = URI("#{BASE_URL}/#{ENDPOINT}?fields=[
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
      request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""
      booking_request = https.request(request)
      response = JSON.parse(booking_request.body)

      return response unless response["status"] == "OK"

      response["data"].map {|d| {
        uid: d["uid"], uuid: d["uuid"], booking_type_uid: d["booking_type_uid"],
        start_time: d["start_time"], duration: d["duration"], reason: d["reason"]
      }}
    end

    def create(payload)
      url = URI("#{BASE_URL}/#{ENDPOINT}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""
      request.body = JSON.dump({
        "model": {
          "entity_uid": payload[:entity_uid] || 5,
          "diary_uid": payload[:diary_uid] || 5,
          "booking_type_uid": payload[:booking_type_uid],
          "booking_status_uid": payload[:booking_status_uid],
          "start_time": payload[:start_time],
          "duration": payload[:duration],
          "patient_uid": payload[:patient_uid],
          "reason": payload[:reason] || 'test',
          "cancelled": payload[:cancelled] || false
        }
      })

      response = https.request(request)
      parse_response(response)
    end

    def update(uid, payload)
      url = URI("#{BASE_URL}/#{ENDPOINT}/#{uid}")
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Put.new(url)
      request["Content-Type"] = "application/json"
      request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""
      request.body = JSON.dump({
        "model": {
          "uid": uid,
          "reason": payload[:reason],
          "duration": payload[:duration],
          "start_time": payload[:start_time],
          "patient_uid": payload[:patient_uid],
        }
      })

      response = https.request(request)
      parse_response(response)
    end

    def delete(uid)
      url = URI("#{BASE_URL}/#{ENDPOINT}/#{uid}")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Delete.new(url)
      request["Content-Type"] = "application/json"
      request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""

      response = https.request(request)
      parse_response(response)
    end

    def types
      url = URI("#{BASE_URL}/api/booking_type?fields=[
        \"uid\",
        \"entity_uid\",
        \"diary_uid\",
        \"name\",
        \"booking_status_uid\",
        \"disabled\",
        \"uuid\"
      ]&filter=[\"AND\",
        [\"=\",
            [\"I\",\"#{@entity_uid}\"],
            [\"L\",5]
        ],
        [\"=\",
            [\"I\",\"diary_uid\"],
            [\"L\",5]
        ],
        [\"NOT\",
            [\"I\",\"disabled\"]
        ]
      ]")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      response = https.request(request)

      parse_response(response)
    end

    def states
      url = URI("#{BASE_URL}/api/booking_status?fields=[
        \"uid\",
        \"entity_uid\",
        \"diary_uid\",
        \"name\",
        \"next_booking_status_uid\",
        \"is_arrived\",
        \"is_final\",
        \"disabled\"
      ]&filter=[\"AND\",
        [\"=\",
            [\"I\",\"entity_uid\"],
            [\"L\",#{@entity_uid}]
        ],
        [\"=\",
            [\"I\",\"diary_uid\"],
            [\"L\",5]
        ],
        [\"NOT\",
            [\"I\",\"disabled\"]
        ]
      ]")

      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["Cookie"] = "session_id=\"\\\"#{@session_id}\\\"_applicant_005\""

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
