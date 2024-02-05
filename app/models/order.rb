# frozen_string_literal: true

# order.rb
class Order < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
end
