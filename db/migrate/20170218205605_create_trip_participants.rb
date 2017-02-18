class CreateTripParticipants < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_participants do |t|
      t.belongs_to :trip, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
