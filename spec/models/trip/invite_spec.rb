require 'rails_helper'

describe Trip::Invite do
  let(:trip_invite) { described_class }

  describe 'validations' do
    it 'factory girl is valid' do
      invite = create(:trip_invite)
      expect(invite).to be_valid
    end

    it 'an invite is invalid without a email' do
      invite = build(:trip_invite, email: '')

      expect(invite).to be_invalid
    end

    it 'email must have the right email format' do
      invite = build(:trip_invite, email: 'invalidformat')
      expect(invite).to be_invalid
    end

    it 'validates uniqueness of email' do
      email = 'test@email.com'
      trip = create(:trip)
      create(:trip_invite, trip: trip, email: email)

      invalid_invite = trip_invite.create(trip: trip, email: email)

      expect(invalid_invite).to be_invalid
    end

    it 'validates uniqueness of email only in scope' do
      email = 'test@email.com'
      trip = create(:trip)
      create(:trip_invite, trip: trip, email: email)

      valid_invite = trip_invite.create(trip: create(:trip), email: email)

      expect(valid_invite).to be_valid
    end
  end

  describe 'after create' do
    it 'calls the Tripmailer with self and the trip' do
      trip = create(:trip)

      expect(TripMailer).to receive(:send_new_invitation).with(an_instance_of(trip_invite), trip).and_call_original
      create(:trip_invite, trip: trip)
    end

    it 'sends an email' do
      expect { create(:trip_invite) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
