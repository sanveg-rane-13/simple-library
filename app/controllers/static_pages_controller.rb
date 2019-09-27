class StaticPagesController < ApplicationController
  def home
    @currentUser = current_user.id        # access current user object after authentication
  end

  def help
  end
end
