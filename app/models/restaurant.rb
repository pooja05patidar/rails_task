# frozen_string_literal: true

# restaurant.rb
class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :menu_items, dependent: :destroy
  paginates_per 5
  has_many :orders
  has_many :reviews, dependent: :destroy
  def self.ransackable_attributes(_auth_object = nil)
    %w[name id]
  end

  def activate_restaurant!
    update_attribute :is_active, true
  end

  def deactivate_restaurant!
    update_attribute :is_active, false
  end

  attribute :ratings, :integer, default: 0
  attribute :is_active, :boolean, default: true
  validates :name, uniqueness: true
end
