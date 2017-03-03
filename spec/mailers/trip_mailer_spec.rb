require "rails_helper"

describe TripMailer do
  let(:mailer) { described_class }

  describe '.send_new_invitation' do
    let(:invite) { build_stubbed(:trip_invite) }
    let(:trip) { invite.trip }
    let(:mail) { mailer.send_new_invitation(invite, trip) }

    it 'sends out the invitation to the invite email' do
      expect(mail.to).to eq([invite.email])
    end

    it 'the subject contains the organiser username and trip name' do
      expect(mail.subject).to include(trip.organiser.username.upcase, trip.name)
    end

    it 'contains the trip invite message' do
      expect(mail.body.encoded).to include(invite.message)
    end

    it 'contains the trip name' do
      expect(mail.body.encoded).to include(trip.name)
    end

    it 'contains the trip description' do
      expect(mail.body.encoded).to include(trip.description)
    end
  end
end
