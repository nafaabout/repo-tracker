require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  mount Sidekiq::Web => '/sidekiq'

  get '/auth/auth0/callback' => 'authentication#callback'
  get '/auth/failure' => 'authentication#failure'
  get '/auth/logout' => 'authentication#logout'

  get '/dashboard' => 'dashboard#show', as: :dashboard
  namespace :settings do
    resources :topics, only: [:index] do
      member do
        post :follow
      end
    end
  end
end
