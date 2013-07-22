Mikedalton::Application.routes.draw do
  get "about", to: "about#index", as: "about"

  resources :posts
  namespace :admin do |admin|
    resources :posts, only: [:index]
  end
  
  #get "admin", to: "admin#index", as: "admin"

  root :to => 'posts#index'
end
