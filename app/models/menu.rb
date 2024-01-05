class Menu < ApplicationRecord
  belongs_to :restaurant
  def self.filter_by_query(search_query)
    where("name LIKE :query OR description LIKE :query", query: "%#{search_query}%")
  end
end
