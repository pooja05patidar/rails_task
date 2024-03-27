# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:menu_item) { create(:menu_item, restaurant: restaurant) }
  let(:order) { create(:order) }

  before { sign_in user }

  describe 'GET /index' do
    it 'returns a successful response' do
      get :index, format: :json
      expect(response).to have_http_status(:success)
      expect(response.body).to include('data')
    end
  end

  describe 'GET show' do
    it 'shows the order' do
      get :show, params: { id: order.id }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_order_params) { build_valid_order_params }

    context 'with valid parameters' do
      it 'creates a new order' do
        post :create, params: valid_order_params
        expect(response).to have_http_status(:success)
        expect(response.code).to eq('200')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new order' do
        post :create, params: { order: { restaurant_id: restaurant.id, menu_item_id: menu_item.id } }
        expect(JSON.parse(response.body)['status']['code']).to eq(422)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the order' do
      delete :destroy, params: { id: order.id }, format: :json
      expect(response).to have_http_status(:success)
    end
  end

  describe 'Private methods' do
    context '#order_item_params' do
      it 'permits valid parameters' do
        valid_params
      end
    end

    describe '#set_order' do
      it 'assigns the correct order' do
        order = create(:order)
        controller.params[:id] = order.id
        expect(controller.send(:set_order)).to eq(order)
      end
    end
  end
end

def valid_params
  params = { order: { quantity: 1, menu_item_id: menu_item.id, total_price: 10.00, user_id: user.id } }
  allow(controller).to receive(:params).and_return(ActionController::Parameters.new(params))
  permitted_params = controller.send(:order_item_params)
  expected_params = build_expected_order_params
  expect(permitted_params).to eq(expected_params)
end

def build_valid_order_params
  {
    order: {
      restaurant_id: restaurant.id,
      menu_item_id: menu_item.id,
      total_price: 10.00,
      user_id: user.id
    }
  }
end

def build_expected_order_params
  ActionController::Parameters.new(
    quantity: 1,
    menu_item_id: 1,
    total_price: 10.0,
    user_id: 1
  ).permit!
end
