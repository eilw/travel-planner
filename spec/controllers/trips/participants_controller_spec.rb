require 'rails_helper'

describe Trips::ParticipantsController do
  let(:user) { create(:user) }
  let(:trip) { create(:trip, participants: [user]) }
  let(:trip_participants) { trip.participants }
  let(:email) { "test@email.com" }
  let(:emails) { "test2@email.com, test3@email.com" }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      post :create, params: { trip_id: trip.id, trip_participant_builder: { emails: email } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe '#create' do
      context 'when successful' do
        context 'when a single email' do
          before { post :create, params: { trip_id: trip.id, trip_participant_builder: { emails: email } } }

          it 'creates a trip participant' do
            expect(trip_participants.where(email: email).count).to eq(1)
          end

          it 'the trip participant is associated to the trip' do
            expect(trip_participants.where(email: email).count).to eq(1)
          end

          it 'redirects to new_trip_participant path' do
            expect(response).to redirect_to(new_trip_participant_path)
          end
        end

        context 'when multiple emails are added' do
          it 'creates a trip participant for each email' do
            trip

            expect { post :create, params: { trip_id: trip.id, trip_participant_builder: { emails: emails } } }
              .to change { trip_participants.count }.by(2)
          end
        end
      end

      context 'when unsuccessful' do
        before { post :create, params: { trip_id: trip.id, trip_participant_builder: { emails: 'invalid' } } }

        it 'no participant is created' do
          expect(trip_participants.where(email: emails).count).to eq(0)
        end

        it 'does not redirect' do
          expect(response).not_to redirect_to(new_trip_participant_path)
        end
      end
    end
  end
end
