# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  include Devise::Test::ControllerHelpers
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  let(:user) { create(:user) }

  describe 'GET #show' do
    context 'when user with id is present' do
      it 'returns a user' do
        get :show, params: { id: user.id }
        expect(response).to be_successful
      end
    end
  end

  context 'get #index' do
    it 'returns all users' do
      get :index
      expect(response).to be_successful
    end
  end

  describe '#respond_to_on_destroy' do
    context 'when Authorization header is present' do
      let(:user) { create(:user) }
      let(:token) { JwtServices.encode(sub: user.id) }

      before do
        request.headers['Authorization'] = "Bearer #{token}"
      end

      it 'returns a success response if the current user is found' do
        allow(controller).to receive(:decode_jwt).and_return('sub' => user.id)
        expect(User).to receive(:find).with(user.id).and_return(user)
        post :respond_to_on_destroy
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include(
          'status' => 200,
          'message' => 'Logged out successfully.'
        )
      end

      it 'returns a failed response if the current user is not found' do
        allow(controller).to receive(:decode_jwt).and_return('sub' => user.id)
        expect(User).to receive(:find).with(user.id).and_return(nil)
        post :respond_to_on_destroy
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include(
          'status' => 401,
          'message' => "Couldn't find an active session."
        )
      end
    end

    context 'when Authorization header is not present' do
      it 'returns an unauthorized response' do
        post :respond_to_on_destroy
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include(
          'status' => 401,
          'message' => "Couldn't find an active session."
        )
      end
    end
  end
end
