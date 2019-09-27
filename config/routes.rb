Rails.application.routes.draw do
  resources :libraries
  resources :books
  get 'authentication/new'
  get 'authentication/edit'
  get "static_pages/home"
  get "static_pages/help"
  get "users/new"

  devise_for :users, controllers: { registrations: "registrations" }

  root "static_pages#home"
end
