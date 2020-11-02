Rails.application.routes.draw do

  root 'startups#terme'
  resources :startups
  devise_for :users, controllers: {
   omniauth_callbacks: 'users/omniauth_callbacks'
   }

  resources :users, only: %i[show index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
