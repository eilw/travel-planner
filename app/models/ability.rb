class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Trip
    can [:update, :read], Trip do |trip|
      trip.participants.include?(user)
    end
    can [:manage], Trip, organiser: user
    can [:destroy], Trip::Invite do |invite|
      invite.trip.organiser == user
    end

    can [:destroy], Trip::Destination do |destination|
      user.trip_participants.include?(destination.creator)
    end

    can [:destroy], Trip::DateOption do |date_option|
      user.trip_participants.include?(date_option.creator)
    end

    can [:destroy], Comment, author: user
  end
end
