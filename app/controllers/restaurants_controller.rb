class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  # before_action :check_owner_approval, only: [:new, :create]
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
    # @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy
    # render json: { status: { code: 200, message: 'Restaurant deleted successfully' } }
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :description, :ratings)
  end
end

# {
#     "status": {
#         "code": 200,
#         "message": "Added to cart successfully"
#     },
#     "data": {
#         "cart_item": {
#             "user_id": 27,
#             "quantity": 8,
#             "menu_id": 8,
#             "id": 4,
#             "created_at": "2024-01-10T18:08:17.511Z",
#             "updated_at": "2024-01-10T21:38:36.199Z"
#         },
#         "total_price": "160.0",
#         "menu": {
#             "id": 8,
#             "name": "Burgur",
#             "description": "burgerb with butter",
#             "price": "80.0"
#         }
#     }
# }
# # cart = {
# #   "userID": 1,
# #   "items": [
# #     {
# #       itemID: "1",
# #       quantity: "1",
# #     }
# #     {
# #       itemID: "2",
# #       quantity: "2",
# #     },
# #   ],
# #   total_price: xxx
# # }
