require 'rails_helper'
require_relative './helpers/users'

feature 'Comment' do
  scenario 'A participant can remove a comment they have added' do
    participant = create(:user)
    trip = create(:trip, participants: [participant])
    destination = create(:trip_destination, trip: trip)

    create(:comment, commentable: destination, author: participant)

    login_user(participant)
    click_link('My trips')
    click_link(trip.name)
    click_link('Remove')
    expect(page).not_to have_content('My comment')
  end

  scenario 'A participant cannot remove a comment from another participant' do
    participant = create(:user)
    trip = create(:trip, participants: [participant])
    destination = create(:trip_destination, trip: trip)

    create(:comment, commentable: destination)

    login_user(participant)
    click_link('My trips')
    click_link(trip.name)
    expect(page).not_to have_selector(:link_or_button, 'Remove', exact: true)
  end
end
