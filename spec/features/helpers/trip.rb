def create_trip(name:, description:)
  click_link('Create a new trip')
  fill_in('trip_name', with: name)
  fill_in('trip_description', with: description)
  click_button('Create trip')
end
