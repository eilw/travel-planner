shared_examples_for "optionable" do
  let(:model) { described_class } # the class that includes the concern
  let(:option) { create(model.to_s.underscore.tr('/', '_').to_sym) }

  describe '#vote_score' do
    it 'returns 0 when there is no votes' do
      expect(option.vote_score).to eq(0)
    end

    it 'returns 1 when there is a yes vote' do
      create(:vote_for, votable: option)
      expect(option.vote_score).to eq(1)
    end

    it 'returns -1 when there is a no vote' do
      create(:vote_against, votable: option)
      expect(option.vote_score).to eq(-1)
    end

    it 'returns 1 when there is a one more yes vote than no vote' do
      create_list(:vote_for, 2, votable: option)
      create(:vote_against, votable: option)
      expect(option.vote_score).to eq(1)
    end
  end
end
