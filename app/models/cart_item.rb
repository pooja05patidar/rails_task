class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :menu_item

  def self.subtotal
    menu_item.price * quantity
  end
end
