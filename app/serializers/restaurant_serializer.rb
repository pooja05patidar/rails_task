# frozen_string_literal: true

# restaurant serializer
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :ratings, :user_id, :is_active
  has_many :menu_items, dependent: :destroy
  has_many :orders
  has_many :reviews, dependent: :destroy
end
