# frozen_string_literal: true

# Cart Items Controller
class CartItemsController < ApplicationController
  before_action :pagination
  def index
    @cart_items = CartItem.all
    render json: { status: { code: 200, message: 'Success' }, data: @cart_items }
  end

  def pagination
    @cart_items = CartItem.page params[:page]
  end

  def show
    @cart_item = CartItem.find(params[:id])
    render json: { status: { code: 200, message: 'Success' }, data: @cart_item }
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    if @cart_item.blank?
      @cart_item.quantity = 1
      @cart_item.user_id = current_user.id
    else
      @cart_item.quantity += 1
    end
    if @cart_item.save
      render_success_response
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def render_success_response
    @cart_items = @cart_items.includes(:menu_item)
    total_price = @cart_item.subtotal
    render json: {
      message: 'Item added to the cart successfully',
      cart_items: current_user.cart_items.as_json(include: { menu_item: { only: %i[id name price] } }),
      total_price: total_price
    }, status: :created
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    render json: { message: 'Item removed from the cart successfully' }
  end

  private

  def cart_item_params
    params.require(:cart_items).permit(:user_id, :quantity, :menu_item_id)
  end
end
