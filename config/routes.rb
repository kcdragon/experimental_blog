Mikedalton::Application.routes.draw do
  resources :posts
  get "about", to: "about#index", as: "about"
  get "admin", to: "admin#index", as: "admin"

  root :to => 'posts#index'
end
