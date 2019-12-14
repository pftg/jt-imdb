# frozen_string_literal: true

Rails.application.routes.draw do
  resources :ratings, only: %i[create update]

  scope ':category', as: 'categorized' do
    resources :movies, only: [:index]
  end

  resources :movies

  devise_for :users

  root 'movies#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
