require 'rails_helper'

RSpec.describe MenuItem, type: :model do
  context 'validates when creating a menu' do
    it 'is valid with all valid parameters' do
      menu_item = FactoryBot.build(:menu_item)
      expect(menu_item).to be_valid
    end

    it 'is invalid without name' do
      menu_item = FactoryBot.build(:menu_item, name: nil)
      expect(menu_item).to_not be_valid
    end

    it 'is invalid without category' do
      menu_item = FactoryBot.build(:menu_item, category: nil)
      expect(menu_item).to_not be_valid
    end
  end

  context 'Associations' do
    it 'belongs to a restaurant' do
      association = described_class.reflect_on_association(:restaurant)
      expect(association.macro).to eq :belongs_to
    end
  end
end
