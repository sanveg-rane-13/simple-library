class RegistrationsController < Devise::RegistrationsController
  private

  def update_resource(resource, params)
    return super if params["password"]&.present?
    resource.update_without_password(params.except("current_password"))
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
