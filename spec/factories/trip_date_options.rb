FactoryGirl.define do
  factory :trip_date_option, class: 'Trip::DateOption' do
    range '17/03/2017 - 20/03/2017'
    trip
  end
end
