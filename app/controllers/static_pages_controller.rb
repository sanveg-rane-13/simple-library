class StaticPagesController < ApplicationController
  def home
    @current_user = current_user        # access current user object after authentication
  end

  def help
  end
end
