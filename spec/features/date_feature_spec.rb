require 'rails_helper'
require_relative './helpers/users'
require_relative './helpers/trip'

feature 'Date' do
  scenario 'A participant can add a new date option' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    click_link('Add date')
    fill_in('trip_date_option_range', with: '17/03/2017 - 20/03/2017')
    click_button('Add date')
    expect(page).to have_content('17/03/2017 - 20/03/2017')
  end
end
