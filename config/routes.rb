Rails.application.routes.draw do
  get 'login', to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  resources :users
  root "main#index"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "upload", to: "songs#new"
  post "upload", to: "songs#create"
  get "songs", to: "songs#index"
  get "songs/:id", to: "songs#play", as: "play_song"
  get "collection/:profile_page", to: "songs#collection", as: "collection"
end
