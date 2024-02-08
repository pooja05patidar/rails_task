require 'rails_helper'

RSpec.describe "RestaurantsController", type: :controller do
  let(:user) { create (:user) }
  describe "GET index" do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end
end
