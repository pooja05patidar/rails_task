# frozen_string_literal: true

# class
class Users::SessionsController < Devise::SessionsController
  before_action :pagination
  def pagination
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end
  # def signout
  #   Devise.sign_out_all_scopes
  #   respond_to_on_destroy
  # end

  # def index
  #   @users = User.all
  #   render json: @users
  # end

  def respond_with(current_user, _opts = {})
    render json: {
      code: 200,
      message: 'Logged in successfully.',
      data: current_user
    }, status: :ok
  end

  def respond_to_on_destroy
    # debugger
    if request.headers['Authorization'].present?
      jwt_payload = decode_jwt
      current_user = User.find(jwt_payload['sub'])
    end
    if current_user.nil?
      return_failed_response
    else
      sign_out current_user
      return_success_response
    end
  end

  private

  def return_success_response
    render json: {
      status: 200,
      message: 'Logged out successfully.'
    }, status: :ok
  end

  def return_failed_response
    render json: {
      status: 401,
      message: "Couldn't find an active session."
    }, status: :unauthorized
    # redirect_to new_user_registration_url, notice: 'logged out successful'
  end

  def decode_jwt
    # debugger
    JWT.decode(
      request.headers['Authorization'].split(' ').last,
      Rails.application.credentials.fetch(:secret_key_base)
    ).first
  end
end
