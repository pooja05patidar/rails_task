require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end
  # debugger
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        ActionMailer::Base.deliveries.clear
        post :create, params: {
          user: FactoryBot.attributes_for(:user)
        }
        # expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('status' => { 'code' => 200, 'message' => 'Signed up successfully', 'data' => anything })

        created_user = User.last
        expect(created_user).to be_present
        expect(created_user.email).to be_present
      end
    end
    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post :create, params: {
          user = FactoryBot.build(:user, email: nil)
          }
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)).to include('status', 'message', 'errors')
          expect(User.count).to eq(0)
        end
      end
  end
end
