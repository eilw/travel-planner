require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { create(:user) }
  let(:subject) { Ability.new(user) }

  describe 'trip' do
    context 'a user' do
      let(:trip) { create(:trip) }
      it { is_expected.to be_able_to(:create, trip) }
      it { is_expected.not_to be_able_to(:read, trip) }
    end

    context 'a participant' do
      let(:trip) { create(:trip, participants: [user]) }
      it { is_expected.to be_able_to(:update, trip) }
      it { is_expected.to be_able_to(:read, trip) }
      it { is_expected.not_to be_able_to(:delete, trip) }
    end

    context 'organiser' do
      let(:trip) { create(:trip, organiser: user) }

      it { is_expected.to be_able_to(:manage, trip) }
    end
  end

  describe 'trip invite' do
    context 'an organiser' do
      let(:trip) { create(:trip, organiser: user) }
      let(:trip_invite) { create(:trip_invite, trip: trip) }

      it { is_expected.to be_able_to(:destroy, trip_invite) }
    end
  end
end
