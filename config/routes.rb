Rails.application.routes.draw do
  root 'static_pages#home'
  get '/signup', to: 'users#new'
  get '/postpage', to: 'users#postpage'
  get '/search', to: 'microposts#search'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :change_password, only: [:edit, :update]
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:show, :create, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  resources :relationships,       only: [:create, :destroy]
  resources :notifications, only: [:index] do
    collection do
      delete 'destroy_all'
    end
  end
end