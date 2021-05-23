Rails.application.routes.draw do
  resources :stocks
  devise_for :users
  root 'home#index'

  post "/", to: "home#index"

  get '/about' => "home#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
