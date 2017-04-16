FactoryGirl.define do
  factory :trip_destination, class: 'Trip::Destination' do
    name 'Sarajevo'
    description 'Best city in Europe'
    trip
    creator { trip.organiser.trip_participants.first }
  end
end
