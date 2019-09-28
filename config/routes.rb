Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  resources :libraries
  resources :books

  get "authentication/new"
  get "authentication/edit"

  get "static_pages/home"
  get "static_pages/help"

  get "users/new"

  resources :libraries do
    get "add_book"
  end

  devise_for :users, controllers: { registrations: "registrations" }

  root "static_pages#home"
end
