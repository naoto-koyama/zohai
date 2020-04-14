require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  namespace :api do
    resources :dividends, only: :index
    resources :dividend_trends, only: :show
    resources :stocks, only: :index
  end
  root to: 'home#index'

  mount Sidekiq::Web, at: "/sidekiq"
end
