Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
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
