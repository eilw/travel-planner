require 'rails_helper'

describe VotesController do
  let(:votable) { create(:trip_destination) }
  let(:user) { User.first }
  login_user

  def vote_for_request
    post :create, params: { vote: 'for', votable_id: votable.id, votable_type: 'trip/destination' }, xhr: true
  end

  def vote_against_request
    post :create, params: { vote: 'against', votable_id: votable.id, votable_type: 'trip/destination' }, xhr: true
  end

  describe '#vote_for' do
    it 'creates a vote for that votable for that participant' do
      vote_for_request
      expect(votable.votes.count).to eq(1)
    end

    it 'creates a yay vote for the votable for that participant' do
      vote_for_request
      expect(votable.votes.first).to be_yay
    end

    it 'a user can only vote once for the votable' do
      create(:vote_for, votable: votable, voter: user)

      vote_for_request

      expect(votable.votes.count).to eq(1)
    end

    it 'switches the yay vote if already voted yes' do
      create(:vote, votable: votable, yay: true, voter: user)
      vote_for_request

      expect(votable.votes.count).to eq(1)
      expect(votable.votes.first).not_to be_yay
    end
  end

  describe '#vote_for' do
    it 'creates a vote for that votable for that participant' do
      vote_against_request
      expect(votable.votes.count).to eq(1)
    end

    it 'creates a yay vote for the votable for that participant' do
      vote_against_request
      expect(votable.votes.first).to be_nay
    end

    it 'a user can only vote once for the votable' do
      create(:vote_against, votable: votable, voter: user)

      vote_against_request

      expect(votable.votes.count).to eq(1)
    end

    it 'switches the nay vote if already voted yes' do
      create(:vote, votable: votable, nay: true, voter: user)
      vote_against_request

      expect(votable.votes.count).to eq(1)
      expect(votable.votes.first).not_to be_nay
    end
  end
end
