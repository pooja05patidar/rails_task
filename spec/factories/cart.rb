# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    # association :cart_item
    association :user
    # quantity { 1 }
  end
end
