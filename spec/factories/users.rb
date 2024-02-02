FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    jti { "xxxxxxxpayloadxxxxxxxJTIxxxxxxx" }
    trait :with_unique_email do
      sequence(:email) { |n| "unique_email_#{n}@example.com" }
    end
    # Traits in FactoryBot are used to group together common attributes or behaviors for factory definitions
  end
end
