Rails.application.routes.draw do

    root 'startups#index'

    resources :startups do
      resources :comments
    end

    devise_for :users, controllers: {
     omniauth_callbacks: 'users/omniauth_callbacks'
     }

    resources :termes

    resources :users, only: %i[show index]

    resources :relationships, only: [:create, :destroy]

    resources :favorites, only: [:create, :destroy]

    resources :conversations do
      resources :messages
    end
end
