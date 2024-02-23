# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user { association :user }
    restaurant { association :restaurant }
    order_id { Faker::Number.unique.number }
  end
end
