require 'rails_helper'

describe Alternatives::VotesController do
  let(:destination) { create(:trip_destination) }
  let(:user) { User.first }
  let(:vote_for_request) { post :vote_for, params: { id: destination.id }, xhr: true }
  let(:vote_against_request) { post :vote_against, params: { id: destination.id }, xhr: true }
  login_user

  describe '#vote_for' do
    it 'creates a vote for that destination for that participant' do
      vote_for_request
      expect(destination.votes.count).to eq(1)
    end

    it 'creates a yay vote for the destination for that participant' do
      vote_for_request
      expect(destination.votes.first).to be_yay
    end

    it 'a user can only vote once for the destination' do
      create(:vote_for, votable: destination, voter: user)

      vote_for_request

      expect(destination.votes.count).to eq(1)
    end

    it 'switches the yay vote if already voted yes' do
      create(:vote, votable: destination, yay: true, voter: user)
      vote_for_request

      expect(destination.votes.count).to eq(1)
      expect(destination.votes.first).not_to be_yay
    end
  end

  describe '#vote_for' do
    it 'creates a vote for that destination for that participant' do
      vote_against_request
      expect(destination.votes.count).to eq(1)
    end

    it 'creates a yay vote for the destination for that participant' do
      vote_against_request
      expect(destination.votes.first).to be_nay
    end

    it 'a user can only vote once for the destination' do
      create(:vote_against, votable: destination, voter: user)

      vote_against_request

      expect(destination.votes.count).to eq(1)
    end

    it 'switches the nay vote if already voted yes' do
      create(:vote, votable: destination, nay: true, voter: user)
      vote_against_request

      expect(destination.votes.count).to eq(1)
      expect(destination.votes.first).not_to be_nay
    end
  end
end
