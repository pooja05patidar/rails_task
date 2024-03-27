# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let(:user) { create(:user) }
  let(:restaurant) { create(:restaurant) }
  let(:valid_attributes) { attributes_for(:review, user_id: user.id, restaurant_id: restaurant.id) }
  let(:invalid_attributes) { attributes_for(:review, rating: nil) }

  before { sign_in user }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, format: :json
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      review = Review.create! valid_attributes
      get :show, params: { id: review.to_param }, format: :json
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'return a new review' do
        post :create, params: { review: valid_attributes }
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'return errors for the new review' do
        post :create, params: { review: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:review) { create(:review, user: user, restaurant: restaurant, rating: 1) }
      let(:new_rating) { 5 }

      it 'updates the requested review' do
        review = Review.create! valid_attributes
        put :update, params: { id: review.id, review: { rating: new_rating }, format: :json }
        review.reload
        expect(review.rating).to eq(new_rating)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the review' do
        review = Review.create! valid_attributes
        put :update, params: { id: review.id, review: invalid_attributes }
        expect(response).to have_http_status(403)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested review' do
      review = Review.create! valid_attributes
      delete :destroy, params: { id: review.id }
    end
  end
end
