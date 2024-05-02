# frozen_string_literal: true

module App
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
                 headers: :any,
                 methods: [:get, :post, :put, :patch, :delete, :options, :head],
                 expose: %w[access-token uid client impersonated],
                 credentials: true
      end
    end
  end
end
