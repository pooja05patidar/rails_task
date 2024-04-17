# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  # protect_from_forgery with: :exception
  include ActionController::Helpers
  include ActionController::Cookies
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied', message: exception.message }, status: :forbidden
  end
end
