require 'rails_helper'

describe Trip::DateOption do
  let(:subject) { described_class }
  let(:date) { create(:trip_date_option) }
  let(:date_range) { '17/03-20/03' }

  describe 'validations' do
    it 'factory is valid' do
      expect(date).to be_valid
    end

    it 'a date without a name is invalid' do
      invalid_date = subject.create(range: nil, trip: build(:trip))
      expect(invalid_date).to be_invalid
    end
  end

  describe 'optionable' do
    it_behaves_like 'optionable'
  end
end
