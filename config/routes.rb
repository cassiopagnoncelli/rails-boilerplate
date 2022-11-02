require 'flipper/ui'
require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq/throttled/web'
require 'sidekiq/cron/web'

Sidekiq::Web.use ActionDispatch::Cookies
Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_boilerplate_session"

Rails.application.routes.draw do
  # Health check available at /health_check(.json)

  devise_for :users
  devise_scope :user do
    namespace :admin, constraints: lambda { |req| AdminAuth.admin?(req) } do
      # Sidekiq
      Sidekiq::Throttled::Web.enhance_queues_tab!
      mount Sidekiq::Web => "/sidekiq"

      # https://www.flippercloud.io/docs/ui
      mount Flipper::UI.app(Flipper) => '/flipper'
    end

    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end

  # Root.
  root to: 'home#index'
end
