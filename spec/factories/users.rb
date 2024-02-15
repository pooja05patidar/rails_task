# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'Password123!' }
    address { Faker::Address.street_address }
    jti { 'xxxxxxxpayloadxxxxxxxJTIxxxxxxx' }
    contact { '7812569034' }
    username { Faker::Internet.username }

    trait :with_unique_email do
      sequence(:email) { |n| "unique_email_#{n}@example.com" }
    end

    trait :owner_pending_approval do
      role { :owner_pending_approval }
    end
  end
end
