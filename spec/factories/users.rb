FactoryGirl.define do
  factory :user do
    username 'test_user'
    sequence(:email) { |n| "user#{n}@example.com" }
    password '12345678'
  end
end
