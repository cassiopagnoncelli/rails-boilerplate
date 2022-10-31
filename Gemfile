source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Asset pipeline.
gem "sprockets-rails"    # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "importmap-rails"    # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "turbo-rails"        # Hotwire"s SPA-like page accelerator [https://turbo.hotwired.dev]
gem "stimulus-rails"     # Hotwire"s modest JavaScript framework [https://stimulus.hotwired.dev]
gem "sassc-rails"        # Use Sass to process CSS
# gem "jsbundling-rails"   # Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
# gem "cssbundling-rails"  # Bundle and process CSS [https://github.com/rails/cssbundling-rails]
# gem "image_processing", "~> 1.2"    # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]

# DevOps related.
# gem "dotenv-rails", require: "dotenv/rails-now"
gem "health_check"

# Databases, seed
gem "pg", "~> 1.1"
gem "redis", "~> 4.0"
gem "connection_pool"

# gem "seedbank"

# Caching
# gem "kredis"             # Use Kredis to get higher-level data types in Redis
# gem "redis-actionpack"

# App server.
gem "puma", "~> 5.6"

# Background jobs.
gem "sidekiq", "~> 6.5.7"
gem "sidekiq-failures"
gem "sidekiq-status"
gem "sidekiq-benchmark"
gem "sidekiq-throttled"
gem "sidekiq-cron"

gem "parallel"

# Admin.
gem "rails_admin"

# Authentication
# gem "jwt"
# gem "omniauth"
# gem "omniauth-google-oauth2", "~> 0.8.0"
# gem "devise"

# Frontend
# gem "slim-rails"
# gem "ruby-progressbar"

# Design patterns
#- gem "interactor-rails"

# API.
#- gem "rack-cors"
#- gem "rack-attack"

#- gem "jbuilder"
#- gem "multi_json"

# Security
# gem "bcrypt", "~> 3.1.7"     # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Annotate models.
  gem "annotate"

  # Print
  gem "awesome_print"
  gem "table_print"

  # Better errors.
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # Linter.
  #- gem "rubocop", require: false
  #- gem "rubocop-performance", require: false

  # Testing.
  #- gem "rspec-rails"
  #- gem "factory_bot_rails"
  # gem "vcr"         # ?
  # gem "webmock"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  # gem "capybara"
  # gem "selenium-webdriver"
  # gem "webdrivers"
end

# Misc utilities.
# gem "holidays"
# gem "cpf_cnpj"

# Excel.
# gem "rubyzip"
# gem "caxlsx"
# gem "acts_as_xlsx"
# gem "caxlsx_rails"

# Feature flags.
#- gem "flipper"
# gem "flipper-active_record"
#- gem "flipper-redis"
#- gem "flipper-ui"

# Analytics.
#- gem "ahoy_matey"
#- gem "rollups"

# Geocoding
#- gem "geocoder"
#- gem "maxminddb"

# ActiveRecord.
#- gem "paper_trail"
#- gem "auto_strip_attributes"

# Engines.
# gem 'stern', path: 'engines/stern'
