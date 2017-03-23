require 'rails_helper'

describe Alternatives::CommentsController do
  let(:destination) { create(:trip_destination) }

  login_user

  describe '#create' do
    context 'when successful' do
      before { post :create, params: { destination_id: destination.id, comment: { text: 'my comment' } } }

      it 'adds a comment to the destination' do
        expect(destination.comments.count).to eq(1)
      end

      it 'redirects to trip path' do
        expect(response).to redirect_to(trip_path(destination.trip))
      end
    end
  end
end
