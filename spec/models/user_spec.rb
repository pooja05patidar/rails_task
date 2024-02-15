# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Validates when creating a user' do
    it 'is valid with all valid attributes' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it 'is invalid without name' do
      user = FactoryBot.build(:user, name: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without a role' do
      user = FactoryBot.build(:user, role: nil)
      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
    end

    it 'has a valid email when created with :with_unique_email trait' do
      user_with_unique_email = FactoryBot.create(:user, :with_unique_email)
      expect(user_with_unique_email).to be_valid
      duplicate_user = FactoryBot.build(:user, :with_unique_email)
      expect(duplicate_user.email).to_not eq(user_with_unique_email.email)
    end

    it 'should raise RecordInvalid for duplicate emails' do
      FactoryBot.create(:user, email: 'duplicate@gmail.com') # should be created
      user2 = FactoryBot.build(:user, email: 'duplicate@gmail.com') # instantiate it and then save
      user2.save
      expect(user2.errors[:email]).to include('has already been taken') # standard way
      # expect(user2).to_not be_valid # works both
    end
  end

  context 'Role Enum' do
    it { should define_enum_for(:role).with_values(customer: 0, owner_pending_approval: 1, owner: 2, admin: 3) }
  end

  context 'Role Default' do
    it 'sets the default role to :customer' do
      user = User.new
      expect(user.role).to eq('customer')
    end
  end

  context 'Custom Methods' do
    it 'has a set_role method' do
      user = User.new
      user.send(:set_role)
      expect(user.role).to eq('customer')
    end
  end

  context 'Associations' do
    it { should have_many(:restaurants).dependent(:destroy) }
    it { should have_many(:reviews).dependent(:destroy) }
    it { should have_one(:order).dependent(:destroy) }
    it { should have_many(:cart_items) }
    it { should have_one(:cart) }
  end
end
