# frozen_string_literal: true

class ChangeColumnInOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :order_id, :integer
    remove_column :orders, :status
    remove_column :orders, :restaurant_id
  end
end
