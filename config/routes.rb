Mikedalton::Application.routes.draw do
  get "about", to: "about#index", as: "about"

  resources :posts, only: [:show, :index]
  namespace :admin do |admin|
    resources :posts, except: [:show, :destroy]
  end

  root :to => 'posts#index'
end
