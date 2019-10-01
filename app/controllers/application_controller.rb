class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!         # authenticate user before any controller action

  # Prevent redirect if route doesn't exist
  rescue_from ActionController::RoutingError do |exception|
    flash[:error] = "There is no such route"
    redirect_to root_url
  end
end
