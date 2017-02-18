class CreateTripInvites < ActiveRecord::Migration[5.0]
  def change
    create_table :trip_invites do |t|
      t.string :email, default: "", null: false
      t.belongs_to :trip, index: true
      t.timestamps
    end
  end
end
