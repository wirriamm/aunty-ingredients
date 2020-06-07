Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :orders, only: [:index, :update, :destroy]
  resources :listings do
    resources :orders, only: [:create]
  end
  resources :payments, only: [:index, :show, :create]
end
