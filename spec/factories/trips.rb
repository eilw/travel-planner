FactoryGirl.define do
  factory :trip do
    name 'My trip'
    description 'My description'
    association :creator, factory: :user
  end
end
