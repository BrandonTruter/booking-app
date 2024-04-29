class EntitiesController < ApplicationController
  def index
    @entity = Entity.all
  end

  def login
    entity = Entity.first
    auth_request = GxWeb::Api::Auth.new({ username: entity.username, password: entity.password })
    session_id = auth_request.session_id

    if session_id.present?
      session[:session_id] = session_id
      cookies[:session_id] = {
        value: session_id,
        expires: 1.year,
        path: '/',
        domain: 'dev_interview.qagoodx.co.za'
      }

      redirect_to diaries_path(entity_id: entity.id)
    else
      redirect_to root_path
    end
  end
end
