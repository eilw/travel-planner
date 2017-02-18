require 'rails_helper'

describe Trips::InvitesController do
  let(:trip) { create(:trip) }
  let(:trip_invite) { Trip::Invite }
  let(:email) { "test@email.com" }
  login_user

  describe '#create' do
    context 'when successful' do
      before { post :create, params: { trip_id: trip.id, trip_invite: { email: email } } }

      it 'creates a trip invite' do
        expect(trip_invite.where(email: email).count).to eq(1)
      end

      it 'the trip invite is associated to the trip' do
        expect(trip.invites.where(email: email).count).to eq(1)
      end

      it 'redirects to the trip path' do
        expect(response).to redirect_to(trip_path(trip))
      end
    end
  end
end
