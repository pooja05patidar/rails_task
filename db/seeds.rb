# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
User.destroy_all
Restaurant.destroy_all
Order.destroy_all

u = User.create!(
    "email": 'user1@gmail.com',
    "password": '12345678'
)
user = User.create!(
  "email": 'user2@gmail.com',
  "password": '12345678'
)

r = u.restaurants.create!(
  "name": 'foodie!!',
  "description": 'Fry it..Try it',
  "ratings": '4.2'
)
res = user.restaurants.create!(
  "name": 'yipie!!',
  "description": 'get everything you want',
  "ratings": '4.3'
)
r.menus.create!(
  "name": "Pizza",
  'description': "today's special",
  "price": '80'
)
r.menus.create!(
  "name": "Sandwich",
  'description': "With all the masala..",
  "price": '70'

)
res.menus.create!(
  "name": "Burgur",
  'description': "burgerb with butter",
  "price": '80'
)
res.menus.create!(
  "name": "Fries",
  'description': "Crunchies",
  "price": '60'

)
