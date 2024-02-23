# frozen_string_literal: true

# restaurant controller
class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner_approval, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  load_and_authorize_resource
  before_action :pagination
  def pagination
    @restaurants = Restaurant.page params[:page]
  end

  def index
    @restaurant = Restaurant.all
    render json: @restaurant
  end

  def show
    if @restaurant.is_active?
      render json: @restaurant
    else
      render json: "#{@restaurant.name} is deactivated"
    end
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
    render json: @restaurant
  end

  def update
    @restaurant.update(restaurant_params)
  end

  def reactivate
    @restaurant = @restaurant.update_attribute(:is_active, true)
    render json: { message: 'Reactivated successfully' }, restaurant: @restaurant
  end

  def destroy
    @restaurant = @restaurant.update_attribute(:is_active, false)
    render json: { message: 'Deactivated' }
  end

  private

  def check_owner_approval
    return unless current_user.owner_pending_approval?
    render json: { error: 'owner request approved yet' }, status: :unprocessable_entity
  end

  def handle_record_not_found
    render json: { error: 'Restaurant not found ' }, status: :not_found
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings, :is_active)
  end
end
