# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    rating { 5 }
    comment { Faker::Lorem.sentence }
    user { association :user }
    restaurant { association :restaurant }
  end
end
