json.status do
  if @restaurant.persisted?
    json.code 200
    json.message 'Restaurant created successfully'
  else
    json.code 422
    json.message 'Restaurant creation failed'
    json.errors @restaurant.errors.full_messages
  end
end
json.data do
  json.id @restaurant.id if @restaurant.persisted?
  json.name @restaurant.name
  json.description @restaurant.description
  json.ratings @restaurant.ratings
end
