# frozen_string_literal: true
class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def create
    build_resource(sign_up_params)

    if resource.save
      sign_up(resource_name, resource)
      UserMailer.welcome_email(resource).deliver_now
      render json: {
        status: { code: 200, message: 'Signed up successfully', data: resource }
      }
    else
      clean_up_passwords resource
      set_minimum_password_length
      render json: {
        status: :unprocessable_entity,
        message: 'User could not be created successfully',
        errors: resource.errors.full_messages
      }
    end
  end
  def apply_for_owner
    # debugger
    current_user.update_columns(role: :owner_pending_approval)
    render json: { message: 'Owner request submitted for approval' }
  end


  private

  def current_user_params
    params.require(:user).permit(:contact) # Adjust the permitted attributes as needed
  end

  def admin_approve_owner
    if current_user.admin?
      user = User.find(params[:user_id])
      user.update(_role: :owner, approved_by_admin: true)
      render json: { message: 'User approved as owner' }
    else
      render json: { message: 'Unauthorized to perform this action' }, status: :unauthorized
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :address, :contact, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :address, :contact, :role])
  end
end
