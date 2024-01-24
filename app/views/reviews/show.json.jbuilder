# frozen_string_literal: true

json.data do
  json.id @review.id
  json.restaurant_id @review.restaurant_id
  json.comment @review.comment
  json.rating @review.rating
end
