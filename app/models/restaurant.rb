# frozen_string_literal: true

# restaurant.rb
class Restaurant < ApplicationRecord
  paginates_per 5
  belongs_to :user
  has_many :menu_items, dependent: :destroy
  has_many :orders
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, uniqueness: true

  attribute :ratings, :integer, default: 0
  attribute :is_active, :boolean, default: true
end
