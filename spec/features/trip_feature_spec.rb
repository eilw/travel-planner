require 'rails_helper'

feature 'Trip' do
  scenario 'Sign up' do
    user = FactoryGirl.create(:user)
    login_as(user)
    expect(page).to have_content('Sign out')
  end

  scenario 'A user can create a new trip' do

  end
end
