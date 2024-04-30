# frozen_string_literal: true

# restaurant controller
class RestaurantsController < ApplicationController
  include ActionController::MimeResponds
  before_action :set_restaurant, only: %i[show edit update reactivate destroy]
  before_action :authenticate_user!
  before_action :check_owner_approval, only: [:create]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  # load_and_authorize_resource
  before_action :pagination

  def pagination
    @restaurants = Restaurant.page params[:page]
  end

  def index
    @restaurants = Restaurant.all
    # render json: @restaurant
  end

  def show
    # if @restaurant.is_active?
    #   render json: @restaurant
    # else
    #   render json: "#{@restaurant.name} is deactivated"
    # end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.new(restaurant_params)
    # @restaurant = current_user.restaurants.create(restaurant_params)
    # render json: @restaurant
    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to restaurant_path(@restaurant.id), notice: 'restaurant created successfully' }
      else
        format.html { render :new, status: 404 }
      end
    end
  end

  def edit; end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to action: :index, notice: 'restaurant updated successfully!'
    else
      render :edit, status: 404
    end
  end

  def reactivate
    @restaurant = @restaurant.update_attribute(:is_active, true)
    # render json: { message: 'Reactivated successfully' }, restaurant: @restaurant
    redirect_to restaurant_path, notice: 'Restaurant reactivated'
  end

  def destroy
    @restaurant = @restaurant.update_attribute(:is_active, false)
    redirect_to restaurant_path, status: :see_other, notice: 'restaurant deactivated successfully!'
    # render json: { message: 'Deactivated' }
  end

  def check_owner_approval
    if current_user.owner_pending_approval?
      render json: { error: 'Your request for owner is not approved yet' }, status: :unprocessable_entity
    end
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def handle_record_not_found
    render json: { error: 'Restaurant not found ' }, status: :not_found
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings, :is_active)
  end
end
