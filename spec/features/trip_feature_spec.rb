require 'rails_helper'
require_relative './helpers/users'
require_relative './helpers/trip'

feature 'Trip' do
  scenario 'A user can create a new trip' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    expect(page).to have_content('A trip')
    expect(page).to have_content('Our trip to Italy')
  end

  scenario 'A user can only see trips created by user' do
    build_stubbed(:trip, name: 'Another trip')
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('My trips')

    expect(page).to have_content('A trip: Our trip to Italy')
    expect(page).not_to have_content('Another trip')
  end

  scenario 'An organiser can delete a trip' do
    user = create(:user)
    trip = create(:trip, organiser: user)
    login_user(user)
    click_link('My trips')
    expect(page).to have_content(trip.name)
    click_link('Remove')
    expect(page).to_not have_content(trip.name)
  end

  scenario 'A participant can not delete a trip' do
    user = create(:user)
    trip = create(:trip, participants: [user])
    login_user(user)
    click_link('My trips')
    expect(page).to have_content(trip.name)
    expect(page).not_to have_selector(:link_or_button, 'Remove', exact: true)
  end
end
