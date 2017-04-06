FactoryGirl.define do
  factory :trip do
    name 'Sarajevo'
    description 'Let us meet there'
    association :organiser, factory: :user
  end
end
