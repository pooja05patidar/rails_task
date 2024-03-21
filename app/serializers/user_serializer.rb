# frozen_string_literal: true

# user serializer
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :contact, :address, :username, :role
end
