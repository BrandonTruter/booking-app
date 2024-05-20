# frozen_string_literal: true

module GxWeb::Api
  class Patient < GxWeb::Request
    def fetch_all
      goodx_request(
        http_method: :get,
        endpoint: '/api/patient?fields=["uid", "debtor_uid", "name", "surname"]'
      )
    end
  end
end
