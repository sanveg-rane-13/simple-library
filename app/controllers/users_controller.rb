class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  # DELETE - Delete the selected student
  # TODO: If student then delete all requests and
  def destroy
    respond_to do |format|
      if current_user.admin?
        if @user.destroy
          format.html { redirect_to view_users_path, notice: "User removed successfully!" }
          format.json { head :no_content }
        else
          format.html { redirect_to view_users_path, alert: "Error removing user" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end
end
