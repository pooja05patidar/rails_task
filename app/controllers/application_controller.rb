class ApplicationController < ActionController::API
  # rescue_from AuthorizationError, with: :authorization_error_response

  # private

  # def authorization_error_response(error)
  #   render json: { error: error.message }, status: error.status
  # end
end
