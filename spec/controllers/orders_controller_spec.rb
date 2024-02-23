require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:user){ create(:user)}
  before {sign_in (user)}
  let(:order){create(:order)}

  describe "GET /index" do
    it 'returns a successful response' do
      get :index, format: :json
      puts response.body
      parsed_body = JSON.parse(response.body)
      expect(parsed_body).to include("data")
    end
    context 'GET show' do
      it 'show the orders' do
        get :show, params: {id:order.id}
        puts response.body
        expect(response).to be_successful
      end
    end
  end
end
