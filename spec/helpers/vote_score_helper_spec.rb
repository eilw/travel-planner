require 'rails_helper'

describe VoteScoreHelper do
  let(:destination) { create(:trip_destination) }

  describe '#for_vote_count' do
    context 'when there are no for votes' do
      it 'returns 0' do
        expect(helper.for_vote_count(destination.votes)).to eq(0)
      end
    end

    context 'no for votes but one none-vote' do
      it 'returns 0' do
        destination.votes << create(:vote, votable: destination)
        expect(helper.for_vote_count(destination.votes)).to eq(0)
      end
    end

    context 'a single for vote' do
      it 'returns 1' do
        destination.votes << create(:vote_for, votable: destination)
        expect(helper.for_vote_count(destination.votes)).to eq(1)
      end
    end

    context 'multiple for_votes' do
      it 'returns the number of votes' do
        number_of_votes = 5
        votes = create_list(:vote_for, number_of_votes, votable: destination)
        destination.votes << votes
        expect(helper.for_vote_count(destination.votes)).to eq(number_of_votes)
      end
    end
  end

  describe '#votes_against' do
    context 'no for votes' do
      it 'returns 0' do
        expect(helper.against_vote_count(destination.votes)).to eq(0)
      end
    end

    context 'no for votes but one none-vote' do
      it 'returns 0' do
        destination.votes << create(:vote, votable: destination)
        expect(helper.against_vote_count(destination.votes)).to eq(0)
      end
    end

    context 'a single for vote' do
      it 'returns 1' do
        destination.votes << create(:vote_against, votable: destination)
        expect(helper.against_vote_count(destination.votes)).to eq(1)
      end
    end

    context 'multiple for_votes' do
      it 'returns the number of votes' do
        number_of_votes = 5
        votes = create_list(:vote_against, number_of_votes, votable: destination)
        destination.votes << votes
        expect(helper.against_vote_count(destination.votes)).to eq(number_of_votes)
      end
    end
  end
end
