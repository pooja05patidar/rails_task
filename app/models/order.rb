# frozen_string_literal: true

# order.rb
class Order < ApplicationRecord
  paginates_per 5
  belongs_to :user
  belongs_to :restaurant
end
