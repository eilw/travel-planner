FactoryGirl.define do
  factory :trip_invite, class: 'Trip::Invite' do
    trip
    email 'Test@email.com'
  end
end
