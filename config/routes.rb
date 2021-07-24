Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "repositories", to: "repositories#index", as: :repositories
  get "repository/:id", to: "repositories#show", as: :repository
  get "repositories/new", to: "repositories#new", as: :new_repository
  post "repositories", to: "repositories#create", as: :create_repository
end
