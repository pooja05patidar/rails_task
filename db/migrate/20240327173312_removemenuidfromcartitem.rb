# frozen_string_literal: true

# class
class Removemenuidfromcartitem < ActiveRecord::Migration[7.1]
  def change
    remove_column :cart_items, :menu_id, :integer
  end
end
