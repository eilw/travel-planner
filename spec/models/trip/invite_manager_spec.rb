require 'rails_helper'

describe Trip::InviteManager do
  let(:manager) { described_class }
  let(:user) { create(:user) }

  describe '.add_trips_to' do
    context 'when invite accepted' do
      it 'adds user to trips' do
        invite = create(:trip_invite, email: user.email, rvsp: true, responded_at: Time.zone.now)
        manager.add_trips_to(user)

        expect(user.trips).to eq([invite.trip])
      end

      it 'only adds trip if it is unique' do
        trip = create(:trip, organiser: user)
        create(:trip_invite, trip: trip, email: user.email, rvsp: true, responded_at: Time.zone.now)

        manager.add_trips_to(user)
        expect(user.trips).to eq([trip])
      end
    end

    context 'when invite not accepted' do
      it 'does not add the user to trips' do
        invite = create(:trip_invite, email: user.email, rvsp: false, responded_at: Time.zone.now)
        manager.add_trips_to(user)

        expect(user.trips).not_to include(invite.trip)
      end
    end
  end

  describe '.invite_accepted' do
    context 'user already exists' do
      it 'adds the user as participant' do
        invite = create(:trip_invite, email: user.email, rvsp: true, responded_at: Time.zone.now)
        manager.invite_accepted(invite: invite, email: user.email)

        expect(user.trips).to eq([invite.trip])
      end
    end

    context 'user doesnt exist' do
      it 'adds the user as participant' do
        email = 'invite@email.com'
        invite = create(:trip_invite, email: email, rvsp: true, responded_at: Time.zone.now)
        expect { manager.invite_accepted(invite: invite, email: email) }
          .not_to change { invite.trip.participants.count }
      end
    end
  end
end
