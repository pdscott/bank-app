Rails.application.routes.draw do

  root to: 'visitors#index'
  devise_for :users, path: 'auth'
  resources :users do
    resources :accounts
    resources :connections
  end

  resources :users
  resources :accounts
  resources :transactions
  resources :connections
end
