class Trip::InviteManager
  class << self
    def add_trips_to(user)
      pending_trips_for(user.email).each do |pending_trip|
        add_participant_to_trip(user: user, trip: pending_trip.trip)
      end
    end

    def add_participant(invite:, email:)
      add_participant_to_trip(user: participant(email), trip: invite.trip)
    end

    def remove_participant(trip:, email:)
      user = user_by(email)
      trip.participants.delete(user) if user
    end

    private

    def participant(email)
      User.find_by(email: email) || User.invite!(email: email)
    end

    def user_by(email)
      User.find_by(email: email)
    end

    def add_participant_to_trip(user:, trip:)
      user.trips << trip unless user.trips.include?(trip)
    end

    def pending_trips_for(email)
      Trip::Invite.where(email: email)
    end
  end
end
