class StaticPagesController < ApplicationController
  before_action :set_user, only: [:approve_librarian]

  # GET
  def approvals
    @current_user = current_user
    @pending_users_list = User.get_pending_approvals_list
  end

  # PUT
  def approve_librarian
    respond_to do |format|
      if @user.update({ pending_approval: false })
        format.html { redirect_to approvals_url, notice: "Librarian approved" }
        format.json { render :show, status: :ok, location: librarian }
      else
        format.html { render :edit }
        format.json { render json: librarian.errors, status: :unprocessable_entity }
      end
    end
  end

  def home
    @current_user = current_user        # access current user object after authentication
  end

  def help
  end


  private

  def set_user
    @user = User.find(params[:id])
  end
end
