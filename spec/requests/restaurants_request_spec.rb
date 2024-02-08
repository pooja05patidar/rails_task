# spec/requests/restaurants_request_spec.rb

require 'rails_helper'

RSpec.describe 'Restaurants', type: :request do
  let!(:restaurant) { create(:restaurant, name: 'RestaurantName', other_attribute: 'value') }
  describe 'GET restaurants#index' do
    it 'returns http success with JSON content' do
      get '/restaurants'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to start_with('application/json') # Check for JSON content type

      # Debug: Print the response body
      puts "Response Body: #{response.body}"

      # Parse the JSON response for further assertions
      json_response = JSON.parse(response.body)
      expect(json_response).not_to be_nil
      expect(json_response).to be_a(Array)
  expect(json_response.length).to be >= 1

  # Check for the presence of the specific restaurant's data
  expect(json_response).to include(restaurant.as_json)

    end
  end
end
