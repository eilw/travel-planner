require 'rails_helper'

describe Trips::InvitesController do
  let(:user) { create(:user) }
  let(:trip) { create(:trip, participants: [user]) }
  let(:trip_invite) { Trip::Invite }
  let(:email) { "test@email.com" }
  let(:emails) { "test2@email.com, test3@email.com" }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      post :create, params: { trip_id: trip.id, trip_invite_builder: { emails: email } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe '#create' do
      context 'when successful' do
        context 'when a single email' do
          before { post :create, params: { trip_id: trip.id, trip_invite_builder: { emails: email } } }

          it 'creates a trip invite' do
            expect(trip_invite.where(email: email).count).to eq(1)
          end

          it 'the trip invite is associated to the trip' do
            expect(trip.invites.where(email: email).count).to eq(1)
          end

          it 'redirects to new_trip_invite path' do
            expect(response).to redirect_to(new_trip_invite_path)
          end
        end

        context 'when multiple emails are added' do
          before { post :create, params: { trip_id: trip.id, trip_invite_builder: { emails: emails } } }

          it 'creates a trip invite for each email' do
            expect(trip_invite.count).to eq(2)
          end
        end
      end

      context 'when unsuccessful' do
        before { post :create, params: { trip_id: trip.id, trip_invite_builder: { emails: 'invalid' } } }

        it 'no invite is created' do
          expect(trip_invite.count).to eq(0)
        end

        it 'does not redirect' do
          expect(response).not_to redirect_to(new_trip_invite_path)
        end
      end
    end

    describe '#destroy' do
      let(:trip) { create(:trip, organiser: user) }
      let!(:trip_invite) { create(:trip_invite, trip: trip) }

      context 'an organiser' do
        it 'deletes the invite' do
          expect { post :destroy, params: { id: trip_invite.id } }.
            to change { Trip::Invite.count }.by(-1)
        end

        it 'redirects to the new trip invite path' do
          post :destroy, params: { id: trip_invite.id }
          expect(response).to redirect_to(new_trip_invite_path(trip))
        end
      end

      context 'an participant' do
        let(:trip) { create(:trip, participants: [user]) }

        it 'raises access is denied' do
          expect { post :destroy, params: { id: trip_invite.id } }.
            to raise_error(CanCan::AccessDenied)
        end
      end
    end

    describe '#update' do
      context 'when invited' do
        let!(:trip_invite) { create(:trip_invite, email: user.email) }

        before { patch :update, params: { id: trip_invite.id, trip_invite: { rvsp: true } } }

        it 'can update the rvsp of the invite' do
          expect(trip_invite.reload.rvsp).to eq(true)
        end

        it 'redirects to the new trip invite path' do
          expect(response).to redirect_to(trips_path)
        end
      end

      context 'when not invited' do
        let!(:trip_invite) { create(:trip_invite) }

        it 'raises access is denied' do
          expect { patch :update, params: { id: trip_invite.id, trip_invite: { rvsp: true } } }
            .to raise_error(CanCan::AccessDenied)
        end
      end
    end
  end
end
