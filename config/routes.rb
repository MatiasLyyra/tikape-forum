Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'categories#index'

  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories

  get 'signin' => 'sessions#new'
  get 'signout' => 'sessions#destroy'
  get 'signup' => 'users#new'
end
