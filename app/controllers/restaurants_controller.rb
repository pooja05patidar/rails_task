class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_owner_approval, only: [:create]
  load_and_authorize_resource

  def index
    # @restaurants = Restaurant.all
    # render json: { status: { code: 200, message: 'Success' }, data: @restaurants }
    @q = Restaurant.ransack(params[:q])
    @restaurants = @q.result.order(:id).per(params[:page]).per(3)
  end

  def show
    # @restaurant = Restaurant.find(params[:id])
    # render json: { status: { code: 200, message: 'Success' }, data: @restaurant }
  end

  def create
    @restaurant = current_user.restaurants.create(restaurant_params)

    # if @restaurant.save
    #   render json: { status: { code: 200, message: 'Restaurant created successfully' }, data: @restaurant }
    # else
    #   render json: { status: { code: 422, message: 'Restaurant creation failed', errors: @restaurant.errors.full_messages } }
    # end
  end

  def update
    # @restaurant = Restaurant.find(params[:id])
    @restaurant.update(restaurant_params)
    # if @restaurant.update(restaurant_params)

    #   render json: { status: { code: 200, message: 'Restaurant updated successfully' }, data: @restaurant }
    # else
    #   render json: { status: { code: 422, message: 'Restaurant update failed', errors: @restaurant.errors.full_messages } }
    # end
  end

  def destroy
    @restaurant.destroy
    # render json: { status: { code: 200, message: 'Restaurant deleted successfully' } }
  end

  private
  def check_owner_approval
    if current_user.owner_pending_approval?
      render json: {error: 'Your request for owner is not approved yet'}, status: :unprocessable_entity
  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings)
  end
end
