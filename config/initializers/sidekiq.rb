# frozen_string_literal: true

require 'sidekiq'
require 'sidekiq-status'
require 'sidekiq-cron'
require 'sidekiq/throttled'

redis_url = ENV.fetch('REDIS_URL') { "redis://redis:6379" }
redis_db = '1'
REDIS_SIDEKIQ = "#{redis_url}/#{redis_db}"
ENABLE_CRON = true

Rails.logger.info "Sidekiq will use Redis at #{REDIS_SIDEKIQ} with cron #{ENABLE_CRON ? 'enabled' : 'disabled'}"

# Server-client.
Sidekiq.configure_server do |config|
  config.redis = { url: REDIS_SIDEKIQ }
  config.failures_max_count = 100 # false or set a number

  config.server_middleware do |chain|
    chain.add Sidekiq::Status::ServerMiddleware, expiration: 30.minutes # default
  end

  schedule_file = 'config/sidekiq_cron.yml'
  if ENABLE_CRON && File.exist?(schedule_file)
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: REDIS_SIDEKIQ, id: "Sidekiq-Boilerplate" }

  config.client_middleware do |chain|
    chain.add Sidekiq::Status::ClientMiddleware
  end
end

# Sidekiq throttling.
Sidekiq::Throttled.setup!

# Sidekiq Web.
# Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
# Sidekiq::Web.set :sessions, Rails.application.config.session_options
# Sidekiq::Web.class_eval do
#   use Rack::Protection #, origin_whitelist: ['https://your.domain'] # resolve Rack Protection HttpOrigin
# end
