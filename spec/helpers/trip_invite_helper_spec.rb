require 'rails_helper'

describe TripInviteHelper do
  let(:invite) { create(:trip_invite) }
  describe 'rvsp state' do
    context 'when rvsp is true' do
      it 'returns Accepted' do
        invite.update(rvsp: true)
        expect(helper.rvsp_state(invite)).to eq("Accepted")
      end
    end

    context 'when rvsp is false' do
      it 'returns Declined' do
        invite.update(rvsp: false)
        expect(helper.rvsp_state(invite)).to eq("Declined")
      end
    end

    context 'when no rvsp is given' do
      context 'when no rvsp is given' do
        it 'returns Pending' do
          expect(helper.rvsp_state(invite)).to eq("Pending")
        end
      end
    end
  end
end
