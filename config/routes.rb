Rails.application.routes.draw do

  root   'top_pages#home'
  get    '/using',  to: 'top_pages#using'
  get    '/signup', to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users
  resources :account_activations, only: [:edit]
  
end
