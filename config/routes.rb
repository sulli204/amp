Rails.application.routes.draw do
  get 'login', to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  get "user/:profile_page", to: "users#show"

  root "main#index"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"
end
