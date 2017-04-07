require 'rails_helper'
require_relative './helpers/users'
require_relative './helpers/trip'

feature 'Trip' do
  scenario 'A user can invite other people to a trip using their emails' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('Trip invites')
    fill_in('trip_invite_builder_emails', with: 'invite@email.com, invite2@email.com')
    fill_in('trip_invite_builder_message', with: 'Trip invite message')
    click_button('Send invitations')

    expect(page).to have_content('Invitations')
    expect(page).to have_content('invite@email.com')
    expect(page).to have_content('invite2@email.com')
    expect(page).not_to have_content('Trip invite description')

    click_link('Back to trip')
    expect(page).to have_content('Trip invites: 2 invitations')
  end

  scenario 'A user gets errors if emails are invalid and duplicate emails are not processed' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('Trip invites')
    fill_in('trip_invite_builder_emails', with: 'inviteemail.com, invite2@email.com, invite2@email.com')
    fill_in('trip_invite_builder_message', with: 'Trip invite message')
    click_button('Send invitations')

    expect(page).to have_content('Email is invalid')
    expect(find_field('Emails').value).to eq 'inviteemail.com'

    click_link('Back to trip')
    expect(page).to have_content('Trip invites: 1 invitations')
  end

  scenario 'The status of the invited users to the trip is shown' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('Trip invites')
    fill_in('trip_invite_builder_emails', with: 'invite@email.com, invite2@email.com, invite3@email.com')
    fill_in('trip_invite_builder_message', with: 'Trip invite message')
    click_button('Send invitations')

    Trip::Invite.find_by(email: 'invite@email.com').update!(rvsp: true)
    Trip::Invite.find_by(email: 'invite2@email.com').update!(rvsp: false)
    visit current_path

    expect(page).to have_content('Accepted')
    expect(page).to have_content('Declined')
    expect(page).to have_content('Pending')
  end

  scenario 'An existing user is added to participants if accepts invite' do
    organiser = create(:user)
    invitee = create(:user)
    trip = create(:trip, organiser: organiser)
    trip_invite = create(:trip_invite, trip: trip, email: invitee.email)
    trip_invite.update!(rvsp: true)
    login_user(invitee)
    click_link('My trips')
    expect(page).to have_content(trip.name)
  end

  scenario 'An organiser can remove a participant from the trip' do
    organiser = create(:user)
    invitee = create(:user)
    trip = create(:trip, organiser: organiser)
    trip_invite = create(:trip_invite, trip: trip, email: invitee.email)
    trip_invite.update!(rvsp: true)

    login_user(organiser)
    click_link('My trips')
    click_link(trip.name)
    click_link('Trip invites')
    click_link('Remove')
    click_link('Back to trip')
    expect(page).to have_content('Trip invites: 0 invitations')

    sign_out(organiser)
    sign_in(invitee)
    click_link('My trips')
    expect(page).to_not have_content(trip.name)
  end

  scenario 'A participant does not have the remove invite option' do
    invitee = create(:user)
    trip = create(:trip, participants: [invitee])
    trip_invite = create(:trip_invite, trip: trip, email: 'test@email.com')
    trip_invite.update!(rvsp: true)

    login_user(invitee)
    click_link('My trips')
    click_link(trip.name)
    expect(page).to have_content('Trip invites: 1 invitations')
    click_link('Trip invites')
    expect(page).not_to have_selector(:link_or_button, 'Remove', exact: true)
  end
end
