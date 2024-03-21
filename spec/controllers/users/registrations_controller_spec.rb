# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:admin_user) { create(:user, role: :admin) }
  let(:owner_user) { create(:user, role: :owner) }
  let(:customer_user) { create(:user, role: :customer)}
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        # ActionMailer::Base.deliveries.clear
        post :create, params: {
          user: FactoryBot.attributes_for(:user)
        }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include(
          'status' => {
            'code' => 200,
            'message' => 'Signed up successfully',
            'data' => anything
          }
        )
        created_user = User.last
        expect(created_user).to be_present
        expect(created_user.email).to be_present
      end
    end

    context 'with invalid params' do
      it 'returns an unprocessable entity response' do
        post :create, params: {
          user: FactoryBot.build(:user, email: nil, contact: nil)
        }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('status', 'message', 'errors')
        expect(User.count).to eq(0)
      end
    end
  end

  describe 'protected methods' do
    let(:params) { ActionController::Parameters.new(user:
      {
        name: 'xyz',
        email: 'xyz@example.com',
        password: 'password',
        address: '123 Street',
        contact: '1234567890',
        role: 'user',
        username: 'xyzz'
      })
    }

    describe '#configure_sign_up_params' do
      it 'permits sign-up parameters' do
        controller.send(:configure_sign_up_params)
        permitted_params = params.require(:user).permit(:name, :email, :password, :address, :contact, :role, :username)
        expect(permitted_params.to_h.keys).to match_array(%w[name email password address contact role username])
      end
    end

    describe '#configure_account_update_params' do
      it 'permits account update parameters' do
        controller.send(:configure_account_update_params)
        permitted_params = params.require(:user).permit(:name, :email, :password, :address, :contact, :role, :username)
        expect(permitted_params.to_h.keys).to match_array(%w[name email password address contact role username])
      end
    end
  end
end
