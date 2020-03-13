Rails.application.routes.draw do
  root 'top_pages#home'
  get 'using', to: 'top_pages#using'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
