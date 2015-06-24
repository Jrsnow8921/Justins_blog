Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }


  root to: 'post#index'
  
  #angular route
  resources :post, only: [:index, :create, :destroy], defaults: {format: :json}

    
  resources :home 
 
  namespace :api do

  end
end
