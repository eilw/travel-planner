require 'rails_helper'

describe Trip::InviteManager do
  let(:manager) { described_class }
  let(:user) { create(:user) }

  describe '.add_trips_to' do
    it 'adds user to trips' do
      invite = create(:trip_invite, email: user.email)
      manager.add_trips_to(user)

      expect(user.trips).to eq([invite.trip])
    end

    it 'only adds trip if it is unique' do
      trip = create(:trip, organiser: user)
      create(:trip_invite, trip: trip, email: user.email)

      manager.add_trips_to(user)
      expect(user.trips).to eq([trip])
    end
  end

  describe '.add_participant' do
    context 'user already exists' do
      it 'adds the user as participant' do
        invite = create(:trip_invite, email: user.email)
        manager.add_participant(invite: invite, email: user.email)

        expect(user.trips).to eq([invite.trip])
      end
    end
  end

  describe '.remove_participant' do
    it 'removes the participant from the trip' do
      trip = create(:trip, participants: [user])
      manager.remove_participant(trip: trip, email: user.email)

      expect(trip.participants).to_not include(user)
    end

    it 'does not delete the user' do
      trip = create(:trip, participants: [user])
      manager.remove_participant(trip: trip, email: user.email)

      expect(user).to be_valid
    end

    it 'deals with if a user cannot be found' do
      trip = create(:trip, participants: [user])
      manager.remove_participant(trip: trip, email: 'incorrect@email.com')

      expect(trip.participants.count).to eq(2)
    end
  end
end
