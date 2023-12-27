# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  before_action :authenticate_user!
  # load_and_authorize_resource

  def index
    @orders = Order.all
    render json: { status: { code: 200, message: 'Success' }, data: @orders }
  end

  def show
    @order = Order.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @order }
  end

  def create
    @order = current_user.build_order(order_params)

    if @order.save
      render json: { status: { code: 200, message: 'Order created successfully' }, data: @order }
    else
      render json: { status: { code: 422, message: 'Order creation failed', errors: @order.errors.full_messages } }
    end
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      render json: { status: { code: 200, message: 'Order updated successfully' }, data: @order }
    else
      render json: { status: { code: 422, message: 'Order update failed', errors: @order.errors.full_messages } }
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    render json: { status: { code: 200, message: 'Order deleted successfully' } }
  end

  private

  def order_params
    params.require(:order).permit(:user_id, :restaurant_id,:time)
  end
end
