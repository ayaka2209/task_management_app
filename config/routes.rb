Rails.application.routes.draw do
  root to: 'users#new'
  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :destroy, :edit, :update]
  namespace :admin do
    resources :users
  end
end
