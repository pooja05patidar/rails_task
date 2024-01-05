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

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :password, :address, :contact, :role])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :password, :address, :contact, :role])
  end
end
