require 'rails_helper'

describe Trips::DestinationsController do
  let(:trip) { create(:trip) }
  let(:user) { trip.organiser }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      post :create, params: { trip_id: trip.id, trip_destination: { name: 'Sarajevo' } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe '#create' do
      context 'when successful' do
        before { post :create, params: { trip_id: trip.id, trip_destination: { name: 'Sarajevo' } } }

        it 'adds a destination to the trip' do
          expect(trip.destinations.count).to eq(1)
        end

        it 'adds the creator' do
          expect(trip.destinations.last.creator).to eq(user.trip_participants.last)
        end

        it 'redirects to trip path' do
          expect(response).to redirect_to(trip_path(trip))
        end
      end
    end

    describe '#destroy' do
      context 'when the creator' do
        let!(:destination) { create(:trip_destination, trip: trip, creator: user.trip_participants.first) }

        it 'deletes the destination' do
          expect { post :destroy, params: { id: destination.id } }.to change { Trip::Destination.all.count }.by(-1)
        end

        it 'redirects to trips path' do
          trip = destination.trip
          post :destroy, params: { id: destination.id }
          expect(response).to redirect_to(trip_path(trip))
        end
      end
    end
  end
end
