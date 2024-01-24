# frozen_string_literal: true

# menu item
class MenuItem < ApplicationRecord
  self.table_name = 'menu_item'
  belongs_to :restaurant
  has_many :cart_items, dependent: :destroy
  def self.filter_by_query(search_query)
    where('name LIKE :query OR description LIKE :query', query: "%#{search_query}%")
  end
end
