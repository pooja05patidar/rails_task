# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:user) { create(:user) }
  let(:cart) { create(:cart, user: user) }
  let(:menu_item) { create(:menu_item) }
  let(:cart_item) { create(:cart_item, cart: cart, menu_item: menu_item) }

  before { sign_in(user) }

  describe 'GET #show' do
    it 'returns a successful response with cart data' do
      get :show
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('data', 'status')
    end
  end

  describe 'POST #add_to_cart' do
    it 'adds an item to the cart' do
      post :add_to_cart, params: { menu_id: menu_item.id }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to include('message', 'cart_items', 'total_price')
    end
  end

  describe 'DELETE #remove_from_cart' do
    it 'removes an item from the cart' do
      delete :remove_from_cart, params: { id: cart_item.id }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)).to include('message')
    end
  end

  describe '#update_cart_item_qty' do
    it 'updates the quantity of a cart item' do
      allow(controller).to receive(:update_cart_item_qty)
      post :add_to_cart, params: { menu_id: menu_item.id }
      expect(controller).to have_received(:update_cart_item_qty)
    end
  end
end
