Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "signup", to: "users#new", as: "signup"
  get "login", to: "sessions#new", as: "login"
  delete "logout", to: "sessions#destroy", as: "logout"

  resources :users
  resources :widgets
  root "widgets#index"
end
