# frozen_string_literal: true

# order controller
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_id, only: %i[show update destroy]
  load_and_authorize_resource
  def index
    @order_items = Order.all
  end

  def show; end

  def create
    restaurant = Restaurant.find(order_item_params[:restaurant_id])
    menu_item = restaurant.menu_items.find(order_item_params[:menu_item_id])

    order = Order.create(order_id: menu_item.id, user_id: order_item_params[:user_id])

    if order.save
      render json: { status: { code: 200, message: 'Order item created successfully' }, data: order }
    else
      render json: { status: { code: 422, message: 'Order item creation failed',
                               errors: order.errors.full_messages } }
    end
  end

  def update
    # debugger
    res_id = params.require(:order_item)[:restaurant_id]
    Restaurant.find(res_id)
    params.require(:order_item)[:menu_item_id]
    if @order_item.update(order_id: ord_item.id, user_id: user_id)
      render json: { status: { code: 200, message: 'Order item updated successfully' }, data: @order_item }
    else
      render json: { status: { code: 422, message: 'Order item update failed',
                               errors: @order_item.errors.full_messages } }
    end
  end

  def destroy
    # debugger
    # @order_item = Order.find(params[:id])
    @order_item.destroy
    # render json: { status: { code: 200, message: 'Order item deleted successfully' } }
    # rescue ActiveRecord::RecordNotFound
    # render json: {message: "Order not found with the specified ID: #{params[:id]}" }, status: :not_found
  end

  private

  def order_item_params
    params.require(:order_item).permit(:order_id, :restaurant_id, :menu_item_id, :quantity, :total_price, :user_id)
  end

  def set_id
    @order_item = Order.find(params[:id])
  end
end
