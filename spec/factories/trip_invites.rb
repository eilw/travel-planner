FactoryGirl.define do
  factory :trip_invite, class: 'Trip::Invite' do
    trip
    email 'Test@email.com'
    message 'This is the trip invite message description'
  end
end
