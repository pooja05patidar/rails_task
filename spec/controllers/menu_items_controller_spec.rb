# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuItemsController, type: :controller do
  let(:owner_user){create(:user, role: 'owner')}
  before {sign_in(owner_user) }
  let(:user){ create(:user)}
  let(:menu_items) {create(:menu_item)}
  describe 'GET menu item' do
    context 'get index' do
      it 'returns a successful response' do
        get :index, format: :json
        puts response.body
        puts response.status
        parsed_body = JSON.parse(response.body)
        expect(parsed_body).to contain_exactly(["data", []])
      end
    end

    context 'get filter menu items' do
      it 'resturns filtered items' do
        menu_item = create(:menu_item, name: 'Burger', description: 'Delicious')
        puts response.body
        get :filter_menu, params: {search_query: 'Burger' }, format: :json
        expect(response).to be_successful
      end
    end

    context 'get show menu item ' do
      it 'returns a menu item ' do
        puts response.body
        puts response.status
        get :show, params: {id: menu_items.id}, format: :json
      end
    end
  end

  describe 'POST create' do
    let(:valid_params){{restaurant_id: 1, name: 'Dish', price: 10.99, category: 'xyz'}}
    before do
      FactoryBot.create(:restaurant, id:1)
    end
    context 'with valid params' do
      it 'creates menu item' do
        post :create, params: {menu_item: valid_params }
        puts response.body
        expect(response).to have_http_status(200)
      end
    end
  end


  describe 'DELETE menu item' do
    context 'delete destroy' do
      it 'deletes an item' do
        delete :destroy, params: {id: menu_items.id}, format: :json
      end
    end
  end
  describe 'menu item params' do
    it 'permits only the allowed parameters' do
      params = {
        menu_item: {
          name: 'Test Item',
          description: 'test Description',
          category: 'xyz'
        }
      }
      allow(controller).to receive(:params).and_return(ActionController::Parameters.new(params))
      permitted_params = controller.send(:menu_item_params)
      expect(permitted_params).to eq(ActionController::Parameters.new(params[:menu_item]).permit(:name, :description, :category))
    end
  end
end
