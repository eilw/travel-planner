# Preview all emails at http://localhost:3000/rails/mailers/trip_mailer
class TripMailerPreview < ActionMailer::Preview
  def send_new_invitation
    trip_invite = Trip::Invite.first

    TripMailer.send_new_invitation(trip_invite, trip_invite.trip)
  end
end
