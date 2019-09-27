Rails.application.routes.draw do
  resources :libraries
  resources :books
  get 'authentication/new'
  get 'authentication/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "static_pages/home"
  get "static_pages/help"

  devise_for :users

  get "users/new"

  root "static_pages#home"
end
