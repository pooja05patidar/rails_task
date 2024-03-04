# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    user do
      association :user, contact: Faker::Number.unique.number(digits: 10).to_s
    end
    restaurant { association :restaurant }
    order_id { Faker::Number.unique.number }
  end
end
