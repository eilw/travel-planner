require 'rails_helper'

describe TripParticipant do
  describe 'validations' do
    it 'factory girl is valid' do
      trip_participant = create(:trip_participant)
      expect(trip_participant).to be_valid
    end

    it 'factory girl organiser and participant are not the same' do
      trip_participant = create(:trip_participant)
      participant = trip_participant.user
      organiser = trip_participant.trip.organiser
      expect(participant.email).not_to eq(organiser.email)
    end

    xit 'cannot be duplicates' do

    end
  end
end
