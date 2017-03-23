require 'rails_helper'

describe Comment do
  let(:subject) { described_class }
  let(:comment) { create(:comment) }

  describe 'validations' do
    it 'factory is valid' do
      expect(comment).to be_valid
    end

    it 'a text is required' do
      comment = subject.create(author: create(:user), commentable: create(:trip_destination))
      expect(comment).to be_invalid
    end
  end

  describe 'added_at' do
    it 'adds timestamps when created' do
      expect(comment.added_at).to be_present
    end
  end
end
