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

  authenticated :admin do
    resources :static_pages do
      get :approvals
      member do
        put :approve_librarian
      end

      # collection do
      #   patch :approve_all_librarians
      # end
    end
  end

  resources :contains do
    get :library_books
  end

  get "approvals", to: "static_pages#approvals"

  root "static_pages#home"
end
