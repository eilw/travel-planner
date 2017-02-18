require 'rails_helper'

describe Trip::Invite do
  describe 'validations' do
    it 'factory girl is valid' do
      invite = create(:trip_invite)
      expect(invite).to be_valid
    end

    it 'a trip is invalid without a email' do
      invite = Trip::Invite.create(trip_id: create(:trip).id, email: '')

      expect(invite).to be_invalid
    end
  end
end
