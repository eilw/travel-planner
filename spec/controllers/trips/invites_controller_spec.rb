require 'rails_helper'

describe Trips::InvitesController do
  let(:user) { create(:user) }
  let(:trip) { create(:trip, participants: [user]) }
  let(:trip_invite) { Trip::Invite }
  let(:email) { "test@email.com" }
  let(:emails) { "test2@email.com, test3@email.com" }

  context 'when logged in' do
    before { sign_in user }

    describe '#destroy' do
      let(:trip) { create(:trip, organiser: user) }
      let!(:trip_invite) { create(:trip_invite, trip: trip) }

      context 'an organiser' do
        it 'deletes the invite' do
          expect { post :destroy, params: { id: trip_invite.id } }.
            to change { Trip::Invite.count }.by(-1)
        end

        it 'redirects to the new trip participant path' do
          post :destroy, params: { id: trip_invite.id }
          expect(response).to redirect_to(new_trip_participant_path(trip))
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

        it 'redirects to the new trip path' do
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
