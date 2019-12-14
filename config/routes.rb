Rails.application.routes.draw do
  resources :ratings
  resources :movies
  devise_for :users

  root 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
