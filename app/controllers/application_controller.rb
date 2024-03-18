# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::Cookies
  config.api_only = true
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied', message: exception.message }, status: :forbidden
  end

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user=(user)
    session[:user_id] = user&.id
  end
end
