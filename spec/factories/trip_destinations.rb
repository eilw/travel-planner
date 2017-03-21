FactoryGirl.define do
  factory :trip_destination, class: 'Trip::Destination' do
    name 'Sarajevo'
    trip
  end
end
