require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :api do
    resources :brand_latest_dividends, only: :index
    resources :dividend_trends, only: :show
    resources :brands, only: :show
  end
  root to: 'home#index'

  mount Sidekiq::Web, at: "/sidekiq"
end
