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
      invalid_destination = subject.create(description: destination_description)
      expect(invalid_destination).to be_invalid
    end
  end

  describe '#votes_for' do
    context 'no for votes' do
      it 'returns 0' do
        expect(destination.votes_for).to eq(0)
      end
    end

    context 'no for votes but one none-vote' do
      it 'returns 0' do
        destination.votes << create(:vote, votable: destination)
        expect(destination.votes_for).to eq(0)
      end
    end

    context 'a single for vote' do
      it 'returns 1' do
        destination.votes << create(:vote_for, votable: destination)
        expect(destination.votes_for).to eq(1)
      end
    end

    context 'multiple for_votes' do
      it 'returns the number of votes' do
        number_of_votes = 5
        votes = create_list(:vote_for, number_of_votes, votable: destination)
        destination.votes << votes
        expect(destination.votes_for).to eq(number_of_votes)
      end
    end
  end

  describe '#votes_against' do
    context 'no for votes' do
      it 'returns 0' do
        expect(destination.votes_against).to eq(0)
      end
    end

    context 'no for votes but one none-vote' do
      it 'returns 0' do
        destination.votes << create(:vote, votable: destination)
        expect(destination.votes_against).to eq(0)
      end
    end

    context 'a single for vote' do
      it 'returns 1' do
        destination.votes << create(:vote_against, votable: destination)
        expect(destination.votes_against).to eq(1)
      end
    end

    context 'multiple for_votes' do
      it 'returns the number of votes' do
        number_of_votes = 5
        votes = create_list(:vote_against, number_of_votes, votable: destination)
        destination.votes << votes
        expect(destination.votes_against).to eq(number_of_votes)
      end
    end
  end
end
