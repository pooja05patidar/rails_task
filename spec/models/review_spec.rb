require 'rails_helper'

RSpec.describe Review, type: :model do
  it 'is valid with valid attributes' do
    review = build(:review)
    expect(review).to be_valid
  end

  it 'is not valid without a comment' do
    review = build(:review, comment: nil)
    expect(review).not_to be_valid
  end

  it 'is not valid with a rating less than 1' do
    review = build(:review, rating: 0)
    expect(review).not_to be_valid
  end

  it 'is not valid with a rating greater than 5' do
    review = build(:review, rating: 6)
    expect(review).not_to be_valid
  end

  it 'belongs to a user' do
    association = described_class.reflect_on_association(:user)
    expect(association.macro).to eq :belongs_to
  end

  it 'belongs to a restaurant' do
    association = described_class.reflect_on_association(:restaurant)
    expect(association.macro).to eq :belongs_to
  end

  it 'paginates per 5' do
    expect(Review.default_per_page).to eq(5)
  end
end
