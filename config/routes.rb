Blog::Application.routes.draw do
  devise_for :admin, :path => '', :path_names => { :sign_in => "admin/sign_in", :sign_out => "admin/sign_out" }

  get "about", to: "about#index", as: "about"

  resources :posts, only: [:show, :index]

  namespace :posts do
    #resource :tags, only: [:destroy]
    delete 'tags', to: 'tags#destroy'
  end

  namespace :admin do |admin|
    resources :posts, except: [:show]
  end

  root :to => 'posts#index'
end
