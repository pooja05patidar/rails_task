# frozen_string_literal: true

json.data @menus do |menu|
  json.id menu.id
  json.name menu.name
  json.description menu.description
  json.price menu.price
  json.restaurant_id menu.restaurant_id
end
# id: nil,
#  name: nil,
#  description: nil,
#  price: nil,
#  restaurant_id: nil,
