def login_user(user = nil)
  user ||= FactoryGirl.create(:user)
  login_as(user)
  visit('/')
end
