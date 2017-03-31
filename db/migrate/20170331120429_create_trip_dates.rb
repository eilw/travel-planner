class CreateTripDates < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_date_options do |t|
      t.string :range, null: false
      t.belongs_to :trip, index: true

      t.timestamps
    end
  end
end
