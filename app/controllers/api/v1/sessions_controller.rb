class Api::V1::SessionsController < ApplicationController
  before_action :load_entity

  def create
    response = login_session

    if response.success?
      token = response.body["data"]["uid"]
      cookies[:session_id] = response.headers['set-cookie']
      session[:entity_id] = token
      @entity.token = token
      @entity.save!

      render json: { token: token }
    else
      render json: { error: response.message }
    end
  end

  def login_session
    begin
      connection.post('/api/session') do |req|
        req.headers[:content_type] = 'application/json'
        req.body = JSON.generate({
          model: {
            timeout: 120
          },
          auth: [
            [
              "password", {
                username: @entity.username,
                password: @entity.password
              }
            ]
          ]
        })
      end
    rescue Faraday::Error => e
      puts e.response[:status]
      puts e.response[:body]
    end
  end

  private

  def load_entity
    @entity = Entity.find_by(
      username: params[:username],
      password: params[:password]
    )
  end

  def connection
    @connection ||= Faraday.new(Rails.application.credentials.gxweb.base_url) do |config|
      config.request :json
      config.response :json
      config.response :raise_error
      config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
    end
  end
end
