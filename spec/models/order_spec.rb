require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to 
    end
    it 'belongs to restaurant ' do
      association = described_class.reflect_on_association(:restaurant)
      expect(association.macro).to eq :belongs_to
    end
  end
end
