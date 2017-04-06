require 'rails_helper'

describe TripsController do
  let(:trip) { create(:trip, organiser: user) }
  let(:user) { create(:user) }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe 'new' do
      it 'renders new' do
        get :new
        expect(response).to have_http_status(:success)
      end
    end

    describe '#show' do
      context 'when not a participant' do
        it 'raises access denied' do
          trip = create(:trip)

          expect { get :show, params: { id: trip.id } }.to raise_error(CanCan::AccessDenied)
        end
      end
    end

    describe '#create' do
      context 'when successful' do
        before { post :create, params: { trip: { name: 'Sarajevo', description: 'A new trip' } } }

        it 'adds a new trip' do
          expect(Trip.all.count).to eq(1)
        end

        it 'redirects to trip path' do
          expect(response).to redirect_to(trip_path(Trip.last))
        end
      end
    end

    describe '#destroy' do
      context 'when an organiser' do
        before { trip }

        it 'deletes the trip' do
          expect { post :destroy, params: { id: trip.id } }.to change { Trip.all.count }.by(-1)
        end

        it 'redirects to trips path' do
          post :destroy, params: { id: trip.id }
          expect(response).to redirect_to(trips_path)
        end
      end

      context 'when a participant' do
        let!(:trip) { create(:trip, participants: [user]) }

        it 'raises access denied' do
          expect { post :destroy, params: { id: trip.id } }.to raise_error(CanCan::AccessDenied)
        end
      end
    end
  end
end
