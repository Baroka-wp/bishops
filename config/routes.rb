Rails.application.routes.draw do

  devise_for :hackers
  root 'startups#terme'
  resources :startups
  devise_for :users
  resources :users, only: %i[show index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
