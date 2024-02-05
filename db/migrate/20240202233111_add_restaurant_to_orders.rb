class AddRestaurantToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :restaurant, foreign_key: true
  end
end
