# frozen_string_literal: true

# restaurant.rb
class Restaurant < ApplicationRecord
  belongs_to :user # , dependent: :destroy
  has_many :menu_items, dependent: :destroy
  has_many :orders # , dependent: :destroy
  has_many :reviews, dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id]
  end
  attribute :ratings, :integer, default: 0
  validates :name, uniqueness: true
end
