# frozen_string_literal: true

module GxWeb
  module Api
    class Diary < GxWeb::Request
      def fetch_all
        goodx_request(
          http_method: :get,
          endpoint: '/api/diary?fields=["uid", "uuid", "booking_type_uid", "name", "booking_types", "booking_statuses"]'
        ) do |request|
          request.params["filter"] = [
            "AND",
            [
              "=",
              ["I","entity_uid"],
              ["L",5]
            ]
          ]
        end
      end
    end
  end
end
