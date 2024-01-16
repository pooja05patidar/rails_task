class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    render json: { status: { code: 200, message: 'Success' }, data: @cart }
  end

  def add_to_cart
    @cart = current_user.cart || current_user.create_cart
    menu = Menu.find(params[:menu_id])

    @cart_item = @cart.cart_items.find_or_initialize_by(menu: menu)

    if @cart_item.new_record?
      @cart_item.quantity = 1
      @cart_item.user_id = current_user.id
    else
      @cart_item.quantity += 1
    end

    if @cart_item.save
      @cart_items = @cart.cart_items.includes(:menu)
      render json: {
        message: 'Item added to the cart successfully',
        cart_items: @cart_items.as_json(include: { menu: { only: [:id, :name, :price] } })
      }, status: :created
    else
      render json: { errors: @cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def remove_from_cart
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    render json: { message: 'Item removed from the cart successfully' }
  end
end
