FactoryGirl.define do
  factory :vote do
    votable { build(:trip_destination) }
    voter { build(:user) }
  end

  factory :vote_for, parent: :vote do
    yay true
  end

  factory :vote_against, parent: :vote do
    nay true
  end
end
