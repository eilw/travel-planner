require 'rails_helper'

describe Trips::DateOptionsController do
  let(:trip) { create(:trip) }
  let(:user) { trip.organiser }

  context 'when not logged in' do
    it 'redirects to sign in path' do
      post :create, params: { trip_id: trip.id, trip_date_option: { range: '17/03/2017 - 20/03/17' } }

      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'when logged in' do
    before { sign_in user }

    describe '#create' do
      context 'when successful' do
        before do
          post :create, params: { trip_id: trip.id, trip_date_option: { range: '17/03/2017 - 20/03/17' } }
        end

        it 'adds a date to the trip' do
          expect(trip.date_options.count).to eq(1)
        end

        it 'adds the creator' do
          expect(trip.date_options.last.creator).to eq(user.trip_participants.last)
        end

        it 'redirects to trip path' do
          expect(response).to redirect_to(trip_path(trip))
        end
      end
    end

    describe '#destroy' do
      context 'when the creator' do
        let!(:date_option) { create(:trip_date_option, trip: trip, creator: user.trip_participants.first) }

        it 'deletes the date_option' do
          expect { post :destroy, params: { id: date_option.id } }.to change { Trip::DateOption.all.count }.by(-1)
        end

        it 'redirects to trips path' do
          trip = date_option.trip
          post :destroy, params: { id: date_option.id }
          expect(response).to redirect_to(trip_path(trip))
        end
      end
    end
  end
end
