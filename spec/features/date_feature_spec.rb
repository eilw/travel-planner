require 'rails_helper'
require_relative './helpers/users'
require_relative './helpers/trip'

feature 'Date' do
  let(:range) { '17/03/17 - 20/03/2017' }

  def add_date
    click_link('Add date')
    fill_in('trip_date_option_range', with: range)
    click_button('Add date')
  end

  scenario 'A participant can add a new date option' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_date
    expect(page).to have_content(range)
  end

  scenario 'A participant can comment on a date option' do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_date
    click_link('Add comment')
    fill_in('comment_text', with: 'Yes, good idea')
    click_button('Done')
    expect(page).to have_content("#{User.first.username}: Yes, good idea")
  end

  scenario 'A participant can only vote up on a date option once', js: true do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_date
    click_button('Like')
    expect(page).to have_content('Like: 1')

    click_button('Like')
    expect(page).to have_content('Like: 1')
  end

  scenario 'A participant can vote like and nope on a date option', js: true do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_date
    click_button('Nope')
    expect(page).to have_content('Nope: 1')
    expect(page).to have_content('Like: 0')

    click_button('Like')
    expect(page).to have_content('Like: 1')
    expect(page).to have_content('Nope: 0')
  end
end
