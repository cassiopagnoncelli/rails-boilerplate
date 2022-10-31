require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq/throttled/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # Health check available at /health_check(.json)

  # Sidekiq
  Sidekiq::Throttled::Web.enhance_queues_tab!
  mount Sidekiq::Web => "/sidekiq"
end
