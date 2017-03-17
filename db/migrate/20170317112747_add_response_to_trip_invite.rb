class AddResponseToTripInvite < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_invites, :rvsp, :boolean
    add_column :trip_invites, :responded_at, :datetime
  end
end
