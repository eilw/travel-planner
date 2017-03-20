require 'rails_helper'

describe User do
  let(:user) { create(:user) }

  describe 'validations' do
    let(:user_attributes) { attributes_for(:user) }
    it 'factory girl is valid' do
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

  describe 'add_user_to_invites' do
    it 'calls the trip_invite to add_user' do
      expect(Trip::InviteManager).to receive(:add_trips_to)
      user
    end
  end
end
