# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API

  rescue_from CanCan::AccessDenied do |exception|
    render json: { error: 'Access denied', message: exception.message }, status: :forbidden
  end
end
