require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not logged in and on the homepage' do
    scenario "should see a 'login' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Log in')
      expect(page).to have_link('Sign up')
    end

    scenario "should not see 'Sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context 'user logged in on the homepage' do
    scenario "should see 'Sign out' link" do
      sign_up
      expect(page).to have_link('Sign out')
      expect(page).not_to have_link('Sign up')
      expect(page).not_to have_link('Log in')
    end
  end
end

feature 'Add invitations when signup' do
  context 'Accepted invite' do
    # Need to link up with invitable
    xscenario 'A user can see trips accepted when joining' do
      create(:trip_invite, email: 'invite@email.com', rvsp: true, responded_at: Time.zone.now)
      sign_up(email: 'invite@email.com')
      click_link('My trips')
      expect(page).to have_content('Reunion')
    end
  end
end

def sign_up(name: 'Name', email: 'test@example.com', password: 'testtest')
  visit('/')
  click_link('Sign up')
  fill_in('user_username', with: name)
  fill_in('user_email', with: email)
  fill_in('user_password', with: password)
  click_button('Sign up')
end
