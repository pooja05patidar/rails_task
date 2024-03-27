# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:cart_item) { create(:cart_item) }
  let(:menu_item) { create(:menu_item) }
  # let(:cart_item) { create(:cart_item, user: user, cart: cart, menu: menu_item) }

  describe 'GET #index' do
    it 'returns a list of cart_item items' do
      get :index
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Success')
    end
  end

  describe 'GET #show' do
    it 'returns a specific cart_item ' do
      get :show, params: { id: cart_item.id }
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Success')
    end
  end

  describe 'POST #create' do
    let(:valid_cart_item_params) do
      {
        cart_item: {
          user_id: user.id,
          cart_id: cart_item.id,
          quantity: 1,
          menu_id: menu_item.id
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new cart_item item' do
        post :create, params: valid_cart_item_params
        expect(response).to have_http_status(:created)
        expect(response.body).to include('Success')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new cart_item item' do
        post :create, params: { cart_item: { user_id: user.id, cart_id: cart_item.id } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['status']['code']).to eq(422)
      end
    end
  end
end
