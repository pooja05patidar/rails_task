# frozen_string_literal: true

FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    price { Faker::Commerce.price }
    category { Faker::Food.ingredient }
    restaurant { association :restaurant }
  end
end
