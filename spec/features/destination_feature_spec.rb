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
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_destination
    click_link('Add comment')
    fill_in('comment_text', with: 'Yes, good idea')
    click_button('Done')
    expect(page).to have_content("#{User.first.username}: Yes, good idea")
  end

  scenario 'A participant can only vote up on a destination option once', js: true do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_destination
    click_button('Like')
    expect(page).to have_content('Like: 1')

    click_button('Like')
    expect(page).to have_content('Like: 1')
  end

  scenario 'A participant can vote like and nope on a destination option', js: true do
    login_user
    create_trip(name: 'A trip', description: 'Our trip to Italy')
    add_destination
    click_button('Nope')
    expect(page).to have_content('Nope: 1')
    expect(page).to have_content('Like: 0')

    click_button('Like')
    expect(page).to have_content('Like: 1')
    expect(page).to have_content('Nope: 0')
  end
end

def add_destination(name: 'Sarajevo option', description: 'Why we should go there')
  click_link('Add destination')
  fill_in('trip_destination_name', with: name)
  fill_in('trip_destination_description', with: description)
  click_button('Add destination')
end

def wait_for_ajax
  Timeout.timeout(Capybara.default_max_wait_time) do
    loop until finished_all_ajax_requests?
  end
end

def finished_all_ajax_requests?
  page.evaluate_script('jQuery.active').zero?
end
