# frozen_string_literal: true

class Api::BaseController < ActionController::API
  include ActionController::Helpers
  include ActionController::Cookies
end
