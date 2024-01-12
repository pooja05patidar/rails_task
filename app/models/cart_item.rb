class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :menu

  def subtotal
    menu.price * quantity
  end
end

  def user
    cart.user if cart
  end
