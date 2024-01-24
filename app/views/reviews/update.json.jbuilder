# frozen_string_literal: true

if @review.errors.empty?
  json.code 200
  json.message 'Review updated'
  json.data do
    json.id @review.id
    json.restaurant_id @review.restaurant_id
    json.comment @review.comment
    json.rating @review.rating
  end

else
  json.code 422
  json.message 'Could not update review'
end
