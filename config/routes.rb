Blog::Application.routes.draw do
  devise_for :admins

  get "about", to: "about#index", as: "about"

  resources :posts, only: [:show, :index]
  namespace :admin do |admin|
    resources :posts, except: [:show]
  end

  root :to => 'posts#index'
end
