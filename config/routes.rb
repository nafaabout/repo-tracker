Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/auth/auth0/callback' => 'authentication#callback'
  get '/auth/failure' => 'authentication#failure'
  get '/auth/logout' => 'authentication#logout'

  get '/dashboard' => 'dashboard#show', as: :dashboard
end
