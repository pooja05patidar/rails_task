# frozen_string_literal: true

FactoryBot.define do
  factory :restaurant do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    ratings { '0' }
    user { association :user }
    is_active { true }
  end
end
# /factories/restaurants.rb
