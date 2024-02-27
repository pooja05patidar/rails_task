# frozen_string_literal: true

# order controller
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show update destroy]
  before_action :pagination
  # load_and_authorize_resource

  def pagination
    @order = Order.page params[:page]
  end

  def index
    @order = Order.all
  end

  def show; end

  def create
    restaurant = Restaurant.find(order_item_params[:restaurant_id])
    menu_item = restaurant.menu_items.find(order_item_params[:menu_item_id])
    order = Order.create(p)
    if order.save
      render json: { status: { code: 200, message: 'Order item created successfully' }, data: order, data: menu_item }
    else
      render json: { status: { code: 422, message: 'Order item creation failed',
                                errors: order.errors.full_messages } }
    end
  end

  # rescue StandardError => e
  #   mssg = e.message
  #   render json: { status: { code: 404, message: mssg }, data: nil }
  def update
    params.require(:order_item)[:menu_item_id]
    if @order_item.update(order_id: ord_item.id, user_id: user_id)
      render json: { status: { code: 200}, data: @order_item }
    else
      render json: { status: { code: 422, errors: @order_item.errors.full_messages } }
    end
  end

  def destroy
    @order_item.destroy
  end

  private
  def p
    restaurant = Restaurant.find(order_item_params[:restaurant_id])
    menu_item = restaurant.menu_items.find(order_item_params[:menu_item_id])
    {
      order_id: menu_item.id,
      user_id: order_item_params[:user_id],
      restaurant_id: order_item_params[:restaurant_id]
    }
  end
  def order_item_params
    params.require(:order).permit( :restaurant_id, :quantity,:menu_item_id, :total_price, :user_id)# :menu_item_id,:order_id,
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
