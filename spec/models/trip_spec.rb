require 'rails_helper'

describe Trip do
  describe 'validations' do
    it 'factory girl is valid' do
      trip = create(:trip)
      expect(trip).to be_valid
    end

    it 'a trip is invalid without a name' do
      trip = Trip.create(organiser: create(:user))
      expect(trip).to be_invalid
    end

    it 'a trip is invalid without a creator' do
      trip = Trip.create(name: 'bla')
      expect(trip).to be_invalid
    end
  end
end
