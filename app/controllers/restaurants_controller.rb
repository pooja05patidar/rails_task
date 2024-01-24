# frozen_string_literal: true

# restaurant controller
class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner_approval, only: [:create]
  load_and_authorize_resource

  def index
    # @q = Restaurant.ransack(params[:q])
    # @restaurants = @q.result.order(:id).per(params[:page]).per(3)
    @restaurant = Restaurant.all
  end

  def show; end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)
  end

  def update
    @restaurant.update(restaurant_params)
  end

  def destroy
    @restaurant.destroy
  end

  private

  def check_owner_approval
    return unless current_user.owner_pending_approval?

    render json: { error: 'Your request for owner is not approved yet' }, status: :unprocessable_entity
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings)
  end
end
