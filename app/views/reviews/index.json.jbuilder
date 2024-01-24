# frozen_string_literal: true

json.data @reviews do |review|
  json.id review.id
  json.restaurant_id review.restaurant_id
  json.comment review.comment
  json.rating review.rating
end
