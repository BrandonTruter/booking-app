class Api::V1::SessionsController < ApplicationController
  before_action :load_entity

  def create
    response = connection.post('/api/session') do |req|
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

    if response.success?
      token = response.body["data"]["uid"]
      cookies[:session_id] = response.headers['set-cookie']
      session[:entity_id] = token
      @entity.token = token
      @entity.save!

      render json: { token: token }
    end
  end

  def render_bookings_json
    begin
      response = connection.get('/api/bookings', { fields: ['uid'] }, { 'Cookie' => "_session_id=#{session[:_session_id]}" })
      render json: response.body
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
    @connection ||= Faraday.new('https://dev_interview.qagoodx.co.za') do |config|
      config.request :json
      config.response :json
      config.response :raise_error
      config.response :logger, Rails.logger, headers: true, bodies: true, log_level: :debug
    end
  end
end
