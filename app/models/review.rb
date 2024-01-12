class Review < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  paginates_per 5
  validates :comment, :rating, presence: true
end
