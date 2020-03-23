Rails.application.routes.draw do
  get 'users/new'

  root 'top_pages#home'
  get '/using',  to: 'top_pages#using'
  get '/signup', to: 'users#new'
  resources :users
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
