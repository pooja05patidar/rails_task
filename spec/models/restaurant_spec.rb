# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context 'Validates when creating a restaurant' do
    it 'is valid with all valid attributes' do
      restaurant = FactoryBot.build(:restaurant)
      expect(restaurant).to be_valid
    end

    it 'is invalid without name' do
      restaurant = FactoryBot.build(:restaurant, name: nil)
      expect(restaurant).to_not be_valid
    end

    it 'is invalid without a non-unique name' do
      create(:restaurant, name: 'existingName')
      restaurant = build(:restaurant, name: 'existingName')
      expect(restaurant).to_not be_valid
    end

    context 'Associations' do
      it 'belongs to a user' do
        association = described_class.reflect_on_association(:user)
        expect(association.macro).to eq :belongs_to
      end

      it 'has many menu items' do
        association = described_class.reflect_on_association(:menu_items)
        expect(association.macro).to eq :has_many
        expect(association.options[:dependent]).to eq :destroy
      end

      it 'has many orders' do
        association = described_class.reflect_on_association(:orders)
        expect(association.macro).to eq :has_many
      end

      it 'has many reviews' do
        association = described_class.reflect_on_association(:reviews)
        expect(association.macro).to eq :has_many
        expect(association.options[:dependent]).to eq :destroy
      end
    end
  end
end
