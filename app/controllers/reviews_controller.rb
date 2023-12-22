# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @reviews = Review.all
    render json: { status: { code: 200, message: 'Success' }, data: @reviews }
  end

  def show
    @review = Review.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @review }
  end

  def create
    # debugger
    @review = current_user.reviews.create(review_params)
    if @review.save
      render json: { status: { code: 200, message: 'Review uploaded successfully' }, data: @review }, status: 422
    else
      render json: { status: { code: 422, message: 'Review Upload failed', errors: @review.errors.full_messages } }
    end
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      render json: { status: { code: 200, message: 'Review updated successfully' }, data: @review }
    else
      render json: { status: { code: 422, message: 'Review update failed', errors: @review.errors.full_messages } }
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    render json: { status: { code: 200, message: 'Review deleted successfully' } }
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :restaurant_id, :rating, :comment)
  end
end
