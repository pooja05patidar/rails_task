# frozen_string_literal: true

# restaurant serializer
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :ratings, :is_active, :menu_items

  def menu_items
    object.menu_items.map do |menu_item|
      {
        id: menu_item.id,
        category: menu_item.category
      }
    end
  end
end
