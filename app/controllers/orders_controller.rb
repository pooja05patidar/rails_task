# frozen_string_literal: true

require_dependency 'order_helper'
# order controller
class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: %i[show update destroy]
  before_action :pagination
  include OrderHelper
  def pagination
    @order = Order.page params[:page]
  end

  def index
    @order = Order.all
  end

  def show; end

  def create
    order = create_order

    if order.save
      render_successful_response(order, @menu_item)
    else
      render_failed_response(order)
    end
  end

  def update
    params.require(:order_item)[:menu_item_id]
    if @order_item.update(order_id: ord_item.id, user_id: user_id)
      render json: { status: { code: 200 }, data: @order_item }
    else
      render json: { status: { code: 422, errors: @order_item.errors.full_messages } }
    end
  end

  def destroy
    @order.destroy(params[:id])
  end

  private

  def order_item_params
    params.require(:order).permit(:restaurant_id, :quantity, :menu_item_id, :total_price, :user_id)
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
