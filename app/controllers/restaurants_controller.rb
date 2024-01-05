class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_owner_approval, only: [:new, :create]
  load_and_authorize_resource

  def index
    @restaurants = Restaurant.all
    render json: { status: { code: 200, message: 'Success' }, data: @restaurants }
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @restaurant }
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)

    if @restaurant.save
      render json: { status: { code: 200, message: 'Restaurant created successfully' }, data: @restaurant }
    else
      render json: { status: { code: 422, message: 'Restaurant creation failed', errors: @restaurant.errors.full_messages } }
    end
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update(restaurant_params)
      render json: { status: { code: 200, message: 'Restaurant updated successfully' }, data: @restaurant }
    else
      render json: { status: { code: 422, message: 'Restaurant update failed', errors: @restaurant.errors.full_messages } }
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    render json: { status: { code: 200, message: 'Restaurant deleted successfully' } }
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings)
  end
end
