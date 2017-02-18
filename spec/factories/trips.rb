FactoryGirl.define do
  factory :trip do
    name 'My trip'
    description 'My description'
    association :organiser, factory: :user
  end
end
