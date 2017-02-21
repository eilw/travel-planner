require 'rails_helper'

describe Trip::InviteBuilder do
  let(:builder) { described_class }
  let(:trip_invite) { Trip::Invite }
  let(:email) { "test@email.com" }
  let(:emails) { "test2@email.com, test3@email.com" }
  let(:message) { "Trip message" }
  let(:trip) { create(:trip) }

  describe 'validations' do
    it 'invalid if not have emails' do
      expect(builder.new).to be_invalid
    end

    it 'is valid with emails' do
      expect(builder.new(emails: email)).to be_valid
    end
  end

  describe 'creating invites' do
    let(:builder) { described_class.new(emails: emails, trip_id: trip.id, message: message) }

    context 'successful invites' do
      it 'creates a trip invite for an email' do
        builder.emails = email

        expect { builder.save }.to change { trip.invites.count }.by(1)
      end

      it 'creates trip invites for multiple emails' do
        expect { builder.save }.to change { trip.invites.count }.by(2)
      end

      it 'the trip invite contains the message' do
        builder.save
        expect(trip.invites.first.message).to eq(message)
      end
    end

    context 'unsuccesful invites' do
      it 'an invalid email is not saved' do
        builder.emails = 'invalid_email'
        expect { builder.save }.not_to change { trip.invites.count }
      end

      it 'adds an error to the emails attribute' do
        builder.emails = 'invalid_email'
        builder.save
        expect(builder.errors[:emails]).to include('Email is invalid')
      end

      it 'does not try to create another invite if the trip already contains an invite with the email' do
        trip.invites.create(email: email)
        builder.emails = email
        builder.save
        expect(builder.errors[:emails].any?).to eq(false)
      end

      it 'does not try to create another invite if the same two emails are added' do
        builder.emails = 'email@email.com, email@email.com'
        builder.save
        expect(builder.errors[:emails].any?).to eq(false)
      end

      it 'the builder keeps the invalid emails' do
        invalid_email = 'invalid_email'
        builder.emails = invalid_email + ',' + email
        builder.save
        expect(builder.emails).to eq(invalid_email)
      end

      it 'the builder keeps the invalid emails in a string' do
        invalid_email = 'invalid_email'
        invalid_email2 = 'invalid'
        builder.emails = invalid_email + ',' + invalid_email2 + ',' + email
        builder.save
        expect(builder.emails).to eq("#{invalid_email}, #{invalid_email2}")
      end

      it 'the builder.save returns false if there are invalid_emails' do
        builder.emails = 'invalid_email'
        expect(builder.save).to eq(false)
      end
    end
  end
end
