class AddCreatorToDestinationAndDateOption < ActiveRecord::Migration[5.0]
  def change
    add_reference :trip_destinations, :creator, foreign_key: { to_table: :trip_participants }
    add_reference :trip_date_options, :creator, foreign_key: { to_table: :trip_participants }
  end
end
