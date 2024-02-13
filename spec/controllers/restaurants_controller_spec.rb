# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  before {sign_in(owner_user)}
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
  let(:owner_user) { create(:user, role: 'owner') }
  before(:each) do
    @valid_params = { name: 'Test Restaurant' }
  end
  let(:invalid_params) { { name: nil } }
  before { sign_in(user) }

  describe 'Post create' do
    context 'Role is owner' do
      before { sign_in(owner_user) }
      it 'creates a new restaurant' do
        post :create, params: { restaurant: { name: 'Test Restaurant' } }
        expect(response).to have_http_status(200)
      end
    end

    context 'Role is customer' do
      it 'does not create restaurant' do
        post :create, params: { restaurant: { name: 'Test Restaurant' } }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'patch update' do
    context 'when user is owner' do
      before { sign_in(owner_user) }
      before do
        @ability = Object.new
        @ability.extend(CanCan::Ability)
        allow(controller).to receive(:current_ability).and_return(@ability)
        @ability.can(:update, restaurant)
      end
      it 'can upadte restaurant' do
        new_name = 'Restaurant'
        patch :update, params: {id: restaurant.id, restaurant: {name: new_name}, format: :json}
        restaurant.reload

        expect(response).to have_http_status(200)
        expect(restaurant.name).to eq(new_name)
      end
    end

    context 'when user is not owner of restaurant' do
      it 'can not update restaurant' do
        new_name = 'Restaurant'
        patch :update, params: {id: restaurant.id, restaurant: {name: new_name}, format: :json}
        expect(response).to have_http_status(403)
        restaurant.reload
        expect(restaurant.name).not_to eq(new_name)
      end
    end
    context 'deactivated restaurant' do
      let (:is_active){true}
      it 'can reactivate restaurant'do
      
  end

  describe 'DELETE deactivate' do
    context 'Role is owner and it created the restaurant' do
      before {sign_in(owner_user)}
      before do
        @ability = Object.new
        @ability.extend(CanCan::Ability)
        allow(controller).to receive(:current_ability).and_return(@ability)
        @ability.can(:destroy, restaurant)
      end
      let(:is_active) {false}
      it 'deactivate restaurant' do
        delete :destroy, params:{id: restaurant.id}
        restaurant.reload
        expect(restaurant.is_active).to be false
        expect(response).to have_http_status(200)
      end
    end

    context 'role is owner but did not created the restaurant' do
      let(:is_active){false}
      it 'do not deactivate restaurant' do
        delete :destroy, params:{id: restaurant.id}
        restaurant.reload
        expect(response).to have_http_status(403)
      end
    end
  end

end
