# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let(:admin_user) { create(:user, role: 'admin') }
  let(:owner_pending_approval_user) { create(:user, role: 'owner_pending_approval') }

  before { sign_in(admin_user) }

  describe 'GET #index' do
    it 'returns a list of owner requests' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'PUT #approve_owner' do
    let(:user_id) { owner_pending_approval_user.id }

    context 'when approval is successful' do
      it 'approves the owner request' do
        put :approve_owner, params: { user_id: user_id }
        expect(response).to have_http_status(:success)
      end
    end

    context 'when approval fails' do
      it 'returns an error message' do
        allow_any_instance_of(User).to receive(:update_columns).and_return(false)
        put :approve_owner, params: { user_id: user_id }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
