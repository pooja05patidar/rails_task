if @restaurant.errors.empty?
  json.code 200
  json.message 'Restaurant updated successfully'
else
  json.code 422
  json.message 'Restaurant update failed'
  json.errors @restaurant.errors.full_messages
end
json.data do
  json.id @restaurant.id
  json.name @restaurant.name
  json.description @restaurant.description
  json.ratings @restaurant.ratings
end
