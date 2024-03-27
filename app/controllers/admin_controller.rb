# frozen_string_literal: true

# admin controller
class AdminController < ApplicationController
  before_action :authenticate_user!
  def index
    @owner_requests = User.where(role: :owner_pending_approval)
    render json: { owner_requests: @owner_requests }
  end

  def approve_owner
    user = User.find(params[:user_id])
    if user.update_columns(role: :owner)
      render json: { message: 'Owner request approved' }
    else
      render json: {
        error: 'Failed to approve owner request',
        errors: user.errors.full_messages,
        user_data: user.as_json
      }, status: :unprocessable_entity
    end
  end
end
