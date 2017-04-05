class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Trip
    can [:update, :read], Trip do |trip|
      trip.participants.include?(user)
    end
    can [:manage], Trip, organiser: user
    can [:destroy], Trip::Invite do |invite|
      Trip.find(invite.trip_id).organiser == user
    end

    can [:read, :create], Trip::InviteBuilder do |builder|
      Trip.find(builder.trip_id).participants.include?(user)
    end
  end
end
