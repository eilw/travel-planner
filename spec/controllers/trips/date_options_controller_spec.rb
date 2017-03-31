require 'rails_helper'

describe Trips::DateOptionsController do
  let(:trip) { create(:trip) }
  login_user

  describe '#create' do
    context 'when successful' do
      before do
        post :create, params: { trip_id: trip.id, trip_date_option: { range: '17/03/2017 - 20/03/17' } }
      end

      it 'adds a date to the trip' do
        expect(trip.date_options.count).to eq(1)
      end

      it 'redirects to trip path' do
        expect(response).to redirect_to(trip_path(trip))
      end
    end
  end
end
