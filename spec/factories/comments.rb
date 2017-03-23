FactoryGirl.define do
  factory :comment do
    text 'My comment'
    author { build(:user) }
    commentable { build(:trip_destination) }
  end
end
