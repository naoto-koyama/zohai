Rails.application.routes.draw do
  namespace :api do
    resources :dividends, only: :index
  end
  root to: 'home#index'
end
