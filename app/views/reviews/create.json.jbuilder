# frozen_string_literal: true

json.status do
  if @review.persisted?
    json.code 200
    json.message 'Review uploaded successfully'
    json.data do
      json.id @review.id
      json.restaurant_id @review.restaurant_id
      json.comment @review.comment
      json.rating @review.rating
    end
  else
    json.code 400
    json.message 'Review could not uploaded'
    json.errors @review.errors.full_messages
  end
end
