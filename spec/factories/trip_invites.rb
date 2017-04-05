FactoryGirl.define do
  factory :trip_invite, class: 'Trip::Invite' do
    trip
    email 'Test@email.com'
    message 'This is the trip invite message description'
  end

  factory :accepted_trip_invite, parent: :trip_invite do
    rvsp true
  end
end
