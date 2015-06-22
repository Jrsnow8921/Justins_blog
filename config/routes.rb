Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions' }

  root to: 'home#index'

  resources :post

  namespace :api do

  end
end
