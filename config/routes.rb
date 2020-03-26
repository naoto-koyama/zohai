Rails.application.routes.draw do
  namespace :api do
    resources :dividends, only: :index
    resources :dividend_trends, only: :show
  end
  root to: 'home#index'
end
