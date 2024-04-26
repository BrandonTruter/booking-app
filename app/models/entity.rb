class Entity < ApplicationRecord
  after_create :set_token

  has_many :diaries

  private

  def set_token
    self.token = session_api["data"]["uid"]
    save!
  end

  def session_api
    require "uri"
    require "json"
    require "net/http"

    url = URI("#{GXWEB_BASE_URL}/api/session")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request.body = JSON.dump({
      "model": {
        "timeout": 259200
      },
      "auth": [
        [
          "password",
          {
            "username": entity.username,
            "password": entity.password
          }
        ]
      ]
    })

    response = https.request(request)
    JSON.parse(response.body)
  end
end
