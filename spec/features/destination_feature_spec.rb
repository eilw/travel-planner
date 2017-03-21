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
end
