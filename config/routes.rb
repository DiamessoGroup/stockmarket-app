Rails.application.routes.draw do

  devise_for :users

  resources :stocks

  root 'home#index'

  post "/", to: "home#index"

  get '/about' => "home#about"

  get '*path', :to => redirect('./404.html')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
