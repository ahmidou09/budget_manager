Rails.application.routes.draw do
  devise_for :users
  root to: 'page#index'

  resources :users
    
  resources :categories do
    resources :transfers
  end
end
