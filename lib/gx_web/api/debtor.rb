# frozen_string_literal: true

module GxWeb::Api
  class Debtor < GxWeb::Request
    def fetch_all
      goodx_request(
        http_method: :get,
        endpoint: '/api/debtor?fields=["uid", "name", "surname", "patients"]'
      )
    end
  end
end
