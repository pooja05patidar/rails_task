# frozen_string_literal: true

# review.rb
class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  paginates_per 5
  validates :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
