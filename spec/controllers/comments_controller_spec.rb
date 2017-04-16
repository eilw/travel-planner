require 'rails_helper'

describe CommentsController do
  let(:user) { create(:user) }
  let(:destination) { create(:trip_destination, trip: create(:trip, organiser: user)) }
  let(:date_option) { create(:trip_date_option) }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      post :create, params:
        {
          commentable_type: 'trip/destination',
          commentable_id: destination.id,
          comment: { text: 'my comment' }
        }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe '#create' do
      context 'when successful' do
        context 'polymorphic destination' do
          before do
            post :create, params:
              {
                commentable_type: 'trip/destination',
                commentable_id: destination.id,
                comment: { text: 'my comment' }
              }
          end

          it 'adds a comment to the destination' do
            expect(destination.comments.count).to eq(1)
          end

          it 'redirects to trip path' do
            expect(response).to redirect_to(trip_path(destination.trip))
          end

          it 'adds the current user as the author' do
            expect(destination.comments.last.author).to eq(User.last)
          end
        end

        context 'polymorphic date option' do
          before do
            post :create, params:
              {
                commentable_type: 'trip/date_option',
                commentable_id: date_option.id,
                comment: { text: 'my comment' }
              }
          end

          it 'adds a comment to the date_option' do
            expect(date_option.comments.count).to eq(1)
          end

          it 'redirects to trip path' do
            expect(response).to redirect_to(trip_path(date_option.trip))
          end
        end
      end
    end

    describe '#destroy' do
      context 'when the creator' do
        let!(:comment) { create(:comment, author: user) }

        it 'deletes the comment' do
          expect { post :destroy, params: { id: comment.id } }.to change { Trip::Comment.all.count }.by(-1)
        end

        it 'redirects to trips path' do
          trip = comment.commentable.trip
          post :destroy, params: { id: comment.id }
          expect(response).to redirect_to(trip_path(trip))
        end
      end
    end
  end
end
