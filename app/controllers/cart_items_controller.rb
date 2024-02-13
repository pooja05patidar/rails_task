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

    if @cart_item.save
      render json: { status: { code: 201, message: 'Cart item created successfully' }, data: @cart_item },
             status: :created
    else
      render json: { status: { code: 422, message: 'Cart item creation failed', errors: @cart_item.errors.full_messages } },
             status: :unprocessable_entity
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:user_id, :cart_id, :quantity, :menu_id)
  end
end
