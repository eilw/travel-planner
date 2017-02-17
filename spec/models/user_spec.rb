require 'rails_helper'

describe User do
  let(:user_attributes) { FactoryGirl.attributes_for(:user) }

  describe 'validations' do
    it 'factory girl is valid' do
      user = FactoryGirl.create(:user)
      expect(user).to be_valid
    end

    it 'requires the presence of a username and unique email' do
      user = User.create(user_attributes)
      expect(user).to be_valid
    end

    it 'a user is invalid without a username' do
      user_attributes[:username] = nil
      user = User.create(user_attributes)
      expect(user).not_to be_valid
    end

    it 'a user is invalid with a duplicate email' do
      User.create(user_attributes)

      user = User.create(user_attributes)
      expect(user).not_to be_valid
    end
  end
end
