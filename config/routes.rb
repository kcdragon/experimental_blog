Mikedalton::Application.routes.draw do
  resources :posts
  get "about", to: "about#index", as: "about"

  root :to => 'posts#index'
end
