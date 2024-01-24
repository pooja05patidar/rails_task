# frozen_string_literal: true

# cart item
class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :menu_item, foreign_key: 'menu_id'

  def subtotal
    menu_item.price * quantity
  end
end
