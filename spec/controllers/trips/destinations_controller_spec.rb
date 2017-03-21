require 'rails_helper'

describe Trips::DestinationsController do
  let(:trip) { create(:trip) }

  login_user

  describe '#create' do
    context 'when successful' do
      before { post :create, params: { trip_id: trip.id, trip_destination: { name: 'Sarajevo' } } }

      it 'adds a destination to the trip' do
        expect(trip.reload.destinations.count).to eq(1)
      end

      it 'redirects to trip path' do
        expect(response).to redirect_to(trip_path(trip))
      end
    end
  end
end
