class TripMailer < ApplicationMailer
  def send_new_invitation(invite, trip)
    @message = invite.message
    @trip = trip
    mail(to: invite.email, subject: "#{trip.organiser.username.upcase} invited you to #{trip.name}")
  end
end
