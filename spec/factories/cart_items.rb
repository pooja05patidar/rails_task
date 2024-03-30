# frozen_string_literal: true

FactoryBot.define do
  factory :cart_item do
    association :menu_item
    quantity { 1 }
  end
end
