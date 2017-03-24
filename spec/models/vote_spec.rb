require 'rails_helper'

describe Vote do
  let(:vote) { create(:vote) }
  let(:for_vote) { create(:vote_for) }
  let(:against_vote) { create(:vote_against) }

  describe 'validations' do
    it 'a participant can only have one vote per votable' do
      invalid = build(:vote, votable: vote.votable, voter: vote.voter)
      expect(invalid).to be_invalid
    end

    it 'a participant cant vote both for and against' do
      expect(build(:vote_for, nay: true)).to be_invalid
    end
  end

  describe '#for' do
    it 'sets yay to true' do
      vote.for
      expect(vote).to be_yay
    end

    it 'switches yay if already voted' do
      for_vote.for
      expect(for_vote).not_to be_yay
    end

    context 'nay is true' do
      it 'sets nay to false' do
        expect { against_vote.for }.to change { against_vote.nay }.from(true).to(false)
      end
    end
  end

  describe '#against' do
    it 'sets nay to true' do
      vote.against
      expect(vote).to be_nay
    end

    it 'switches nay if already voted' do
      against_vote.against
      expect(against_vote).not_to be_nay
    end

    context 'yay is true' do
      it 'sets yay to false' do
        expect { for_vote.against }.to change { for_vote.yay }.from(true).to(false)
      end
    end
  end
end
