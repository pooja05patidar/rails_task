# frozen_string_literal: true

class AddCartToCartItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :cart_items, :cart, foreign_key: true
  end
end
