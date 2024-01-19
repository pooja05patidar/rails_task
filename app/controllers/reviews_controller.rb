# app/controllers/reviews_controller.rb
class ReviewsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :pagination

  def pagination
    @reviews = Review.page params[:page]
  end

    def index
    # @reviews = Review.all
    # render json: { status: { code: 200, message: 'Success' }, data: @reviews }
  end

  def show
    # @review = Review.find(params[:id])
    # render json: { status: { code: 200, message: 'Success' }, data: @review }
  end

#   def create
#     # debugger
#     @review = current_user.reviews.create(review_params)
#     # if @review.save
#     #   render json: { status: { code: 200, message: 'Review uploaded successfully' }, data: @review }, status: 422
#     # else
#     #   render json: { status: { code: 422, message: 'Review Upload failed', errors: @review.errors.full_messages } }
#     # end
#   end

#   def update
#     @review.update(review_params)
#     # if @review.update(review_params)
#     #   render json: { status: { code: 200, message: 'Review updated successfully' }, data: @review }
#     # else
#     #   render json: { status: { code: 422, message: 'Review update failed', errors: @review.errors.full_messages } }
#     # end
#   end

#   def destroy
#     @review.destroy
#     # render json: { status: { code: 200, message: 'Review deleted successfully' } }
#   end

#   private

#   def review_params
#     params.require(:review).permit(:user_id, :restaurant_id, :rating, :comment)
#   end

#   def get_review
#     @review = Review.find(params[:id])
#   end

# end
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
    debugger
    return unless restaurant.present?

    total_ratings = restaurant.reviews.sum(:rating)
    total_reviews = restaurant.reviews.count

    new_average_rating = total_reviews.positive? ? total_ratings / total_reviews.to_f : 0

    restaurant.update_columns(ratings: new_average_rating)
  end
end
