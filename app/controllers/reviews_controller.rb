# frozen_string_literal: true

# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :pagination

  def pagination
    @reviews = Review.page params[:page]
  end

  def index; end

  def show; end

  def create
    @review = current_user.reviews.create(review_params)

    if @review.save
      update_average_rating(@review.restaurant)
      render json: @review, status: :created
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      update_average_rating(@review.restaurant)
      render json: @review
    else
      render json: { errors: @review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    restaurant = @review.restaurant
    @review.destroy
    update_average_rating(restaurant)

    head :no_content
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :restaurant_id, :rating, :comment)
  end

  def get_review
    @review = Review.find(params[:id])
  end

  def update_average_rating(restaurant)
    return unless restaurant.present?
    total_ratings = restaurant.reviews.sum(:rating)
    total_reviews = restaurant.reviews.count
    if total_reviews.positive?
      new_average_rating = total_ratings / total_reviews
    else
      new_average_rating = 0
    end
    restaurant.update_columns(ratings: new_average_rating)
  end
end
