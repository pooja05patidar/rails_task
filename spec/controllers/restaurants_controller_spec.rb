# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant, is_active: is_active) }
  let(:is_active) { true }

  describe 'GET index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'get show' do
    context 'when restaurant is active' do
      it 'returns a successful response' do
        get :show, params: { id: restaurant.id }
        expect(response).to be_successful
        expect(restaurant.is_active).to be true
      end
    end
    context 'when restaurant is not active' do
      let(:is_active) { false }
      it 'returns response that restaurant is deactivated' do
        get :show, params: { id: restaurant.id }
        expect(response).to be_successful
        expect(restaurant.is_active).to be false
      end
    end
  end
  let(:user) {create(:user)}
  let(:owner_user) {create(:user, role: 'owner')}
  let(:valid_params) {{name: "Test Restaurant"}}
  let(:invalid_params){{name: nil}}
  before {sign_in(user)}

  describe "Post create" do
    context 'Role is owner' do
      before {sign_in(owner_user)}
      it "creates a new restaurant" do
        post :create, params: {restaurant: valid_params}
        expect(response).to have_http_status(200)
      end
    end
  end
end
