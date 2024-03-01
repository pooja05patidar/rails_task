# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact, :address, :username, :role
  has_many :restaurants, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :order, dependent: :destroy
  has_many :cart_items
  has_one :cart
end
