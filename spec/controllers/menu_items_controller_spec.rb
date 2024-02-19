# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MenuItemsController, type: :controller do
  let(:owner_user){create(:user, role: 'owner')}
  before {sign_in(owner_user) }
  let(:user){ create(:user)}
  # let(:restaurant) { create(:restaurant, is_active: true)}
  let(:menu_items) {create(:menu_item)}
  describe 'GET menu item' do

    # context 'get index' do
    #   it 'returns a successful response' do
    #     get :index
    #     puts response.body
    #     puts response.status
    #     expect(response).to be_successful
    #   end
    # end

    # 'get filter menu items' do
    #   it 'resturns filtered items' do
    #     menu_item = create(:menu_item, name: 'Burger', description: 'Delicious')
    #     get :filter_menu, params: {search_query: 'Burger' }
    #     puts response.body
    #     expect(response).to be_successful
    #   end
    # end

    context 'show menu item ' do
      it 'returns a menu item ' do
        get :show, params: {id: menu_items.id}
        puts response.body
        puts response.status
      end
    end
  end
end
