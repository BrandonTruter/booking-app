source "https://rubygems.org"

ruby "3.2.0"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "sass-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "hotwire-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem 'rack-cors'
gem 'http-cookie'
gem 'faraday'
gem 'faraday-cookie_jar'
gem 'faraday-net_http_persistent', '~> 2.0'
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem 'active_model_serializers'
gem 'redis-rails', '~> 5.0'

group :development, :test do
  gem 'annotate', '~> 3.2', '>= 3.0.3'
  gem 'factory_bot_rails', '~> 6.4'
  gem 'rspec-rails', '~> 6.1'
  gem 'faraday-retry', '~> 2.2'
end

group :development do
  gem "web-console"
  gem 'better_errors', '~> 2.10'
  gem 'binding_of_caller', '~> 1.0'
  gem 'listen', '~> 3.9'
end

group :test do
  gem 'capybara', '~> 3.40'
  gem 'selenium-webdriver', '~> 4.19.0'
  gem 'shoulda-matchers', '~> 6.2'
  gem 'webmock', '~> 3.23'
  gem 'rack_session_access'
end
