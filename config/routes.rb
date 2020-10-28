Rails.application.routes.draw do

  root 'startups#terme'
  resources :startups
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
