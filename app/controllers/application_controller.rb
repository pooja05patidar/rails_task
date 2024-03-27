# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ActionController::Cookies
  config.api_only = true
  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied', message: exception.message }, status: :forbidden
  end
end
