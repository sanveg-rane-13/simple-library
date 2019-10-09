Rails.application.routes.draw do
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"

  resources :libraries
  resources :books
  resources :requests
  resources :contains

  get "authentication/new"
  get "authentication/edit"

  get "static_pages/home"
  get "static_pages/help"

  devise_for :users, controllers: { registrations: "registrations" }
  get "users/new"
  # scope "admin" do
  #   delete "users/:id", to: "users#destroy"
  # end
  match "users/:id" => "users#destroy", :via => :delete, :as => :admin_destroy_user

  resources :static_pages do
    put "approve_librarian", on: :member
  end
  get "approvals", to: "static_pages#approvals"

  resources :requests do
    member do
      post "approve_spl"
      post "decline_spl"
    end
    collection do
      post "check_out_book"   # checkout a book
      post "return_book"      # return checked out book
      post "hold_book"        # put a book on hold
      post "rem_hold_book"    # remove book from hold
      post "bookmark"         # bookmark a book
      post "remove_bookmark"  # remove bookmark
    end
  end

  # custom get routes for request controller
  get "view_hold", to: "requests#view_hold"
  get "manage_req", to: "requests#manage_req"
  get "spl_book_aprvl", to: "requests#spl_book_aprvl"
  get "view_borrow_history", to: "requests#view_borrow_history"
  get "view_overdue_fine", to: "requests#view_overdue_fine"
  get "view_users", to: "requests#view_users"
  get "view_bookmarks", to: "requests#view_bookmarks"

  resources :contains do
    member do
      get :show_lib_book      # show details of particular book from library
    end
  end

  resources :libraries do
    member do
      get :lib_books
    end
  end
  get "user_libs", to: "libraries#user_libs"

  root "static_pages#home"
end
