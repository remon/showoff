Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "signup", to: "users#new", as: :signup
  get "login", to: "sessions#new", as: :login
  get "me", to: "users#me", as: :me
  get "mywidgets", to: "widgets#mywidgets", as: :mywidgets
  get "reset_password", to: "sessions#reset_password", as: :reset_password
  post "send_reset_instructions", to: "sessions#send_reset_instructions", as: :send_reset_instructions
  delete "logout", to: "sessions#destroy", as: :logout
  resources :sessions
  resources :users
  resources :widgets
  root "widgets#index"
end
