# spec/models/cart_item_spec.rb

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe '#subtotal' do
    let(:cart_item) { build(:cart_item, menu_item: create(:menu_item, price: 10), quantity: 2) }

    it 'calculates the subtotal correctly' do
      expect(cart_item.subtotal).to eq(20)
    end
  end

  describe 'associations' do
    it { should belong_to(:cart) }
    # it { should belong_to(:menu_item).with_foreign_key('menu_item_id') }
  end
end
