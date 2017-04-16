FactoryGirl.define do
  factory :trip do
    name 'Reunion'
    description 'Let us organise it'
    association :organiser, factory: :user
  end
end
