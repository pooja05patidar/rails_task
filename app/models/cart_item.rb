# frozen_string_literal: true

# cart item
class CartItem < ApplicationRecord
  belongs_to :cart
  # self.table_name = 'menu_item'
  belongs_to :menu_item, foreign_key: 'menu_item_id'
  paginates_per 5
  def subtotal
    menu_item.price * quantity
  end
end
