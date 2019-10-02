class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    edit_user_registration_path resource
  end

  def after_update_path_for(resource)
    edit_user_registration_path resource
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :student, :librarian)
  end

  def update_resource(resource, params)
    return super if params["password"]&.present?
    resource.update_without_password(params.except("current_password"))
  end

  def after_update_path_for(resource)
    "/"
    # "http://localhost:3000"
  end

  # permitting parameters for user creation
  def sign_up_params
    params.require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :university,
        :pending_approval,
        :admin,
        :student,
        :librarian
      )
  end

  # permitting parameters for user updates
  def account_update_params
    params.require(:user)
      .permit(
        :name,
        :email,
        :password,
        :password_confirmation,
        :study_level,
        :current_password,
        :university,
        :pending_approval,
        :admin,
        :student,
        :librarian,
        :library_id
      )
  end
end
