Rails.application.routes.draw do

  root   'top_pages#home'
  get    '/using',   to: 'top_pages#using'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/meeting/:date/new', to:'meeting#new'
  post   '/schedule',to: 'meeting#create'
  #facebookログイン
  get    '/auth/:provider/callback', to: 'users#facebook_login', as: :auth_callback
  get    '/auth/failure',            to: 'users#auth_failure',   as: :auth_failure
  #お試しログイン
  get    '/login_trial_user',  to:'users#trial_login'
  delete '/logout_trial_user', to:'users#trial_user_destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :meeting
  resources :relationships,       only: [:create, :destroy]
  
end
