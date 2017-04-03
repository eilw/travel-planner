require 'rails_helper'

describe Trip::Destination do
  let(:subject) { described_class }
  let(:destination) { create(:trip_destination) }
  let(:destination_description) { 'A description' }

  describe 'validations' do
    it 'factory is valid' do
      expect(destination).to be_valid
    end

    it 'a destination without a name is invalid' do
      invalid_destination = subject.create(description: destination_description, trip: build(:trip))
      expect(invalid_destination).to be_invalid
    end
  end
end
