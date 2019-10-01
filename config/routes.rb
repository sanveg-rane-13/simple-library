Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  resources :libraries
  resources :books
  resources :requests
  resources :contains

  get "users/new"

  get "authentication/new"
  get "authentication/edit"

  get "static_pages/home"
  get "static_pages/help"

  devise_for :users, controllers: { registrations: "registrations" }

  resources :static_pages do
    put "approve_librarian", on: :member
  end

  resources :requests do
    collection do
      post "check_out_book"
      post "return_book"
    end
  end

  resources :contains do
    member do
      get :show_lib_book   # show details of particular book from library
    end
  end

  resources :libraries do
    member do
      get :lib_books
    end
  end

  # custom routes
  get "approvals", to: "static_pages#approvals"
  get "user_libs", to: "libraries#user_libs"

  root "static_pages#home"
end
