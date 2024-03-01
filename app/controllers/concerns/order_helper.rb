# frozen_string_literal: true

# order_helper.rb
module OrderHelper
  extend ActiveSupport::Concern

  included do
    before_action :find_restaurant, only: :create
    before_action :find_menu_item, only: :create
  end

  def find_restaurant
    @restaurant = Restaurant.find(order_item_params[:restaurant_id])
  end

  def find_menu_item
    @menu_item = @restaurant.menu_items.find(order_item_params[:menu_item_id])
  end

  def create_order
    Order.create(required_params)
  end

  def render_successful_response(order, menu_item)
    render json: {
      status: { code: 200, message: 'Order item created successfully' },
      data: { order: order, menu_item: menu_item }
    }
  end

  def render_failed_response(order)
    render json: {
      status: {
        code: 422,
        message: 'Order item creation failed',
        errors: order.errors.full_messages
      }
    }
  end

  private

  def required_params
    {
      order_id: @menu_item.id,
      user_id: order_item_params[:user_id],
      restaurant_id: order_item_params[:restaurant_id]
    }
  end
end
