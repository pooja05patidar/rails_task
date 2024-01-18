class ApplicationController < ActionController::API
  rescue_from CanCan::AccessDenied, with: :handle_unauthorized_access
  def authenticate_admin!
    render json: { message: 'Unauthorized' }, status: :unauthorized unless current_user&.admin?
  end
  private

  def handle_unauthorized_access(exception)
    flash[:alert] = "Sorry, you are not authorized to access this page. #{exception.message}"
  end

end
