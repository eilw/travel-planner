require 'rails_helper'
require_relative './helpers/users'
require_relative './helpers/trip'

feature 'Destination' do
  scenario 'A participant can add a new destination option' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('Add destination')
    fill_in('trip_destination_name', with: 'Sarajevo option')
    fill_in('trip_destination_description', with: 'Why we should go there')
    click_button('Add destination')
    expect(page).to have_content('Sarajevo option: Why we should go there')
  end

  scenario 'A participant can comment on a destination option' do
    login_user
    user = User.first
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_destination
    click_link('Add comment')
    fill_in('comment_text', with: 'Yes, good idea')
    click_button('Done')
    expect(page).to have_content("#{user.username}: Yes, good idea")
  end
end

def add_destination(name: 'Sarajevo option', description: 'Why we should go there')
  click_link('Add destination')
  fill_in('trip_destination_name', with: name)
  fill_in('trip_destination_description', with: description)
  click_button('Add destination')
end
