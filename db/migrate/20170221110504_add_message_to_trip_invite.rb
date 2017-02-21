class AddMessageToTripInvite < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_invites, :message, :text
  end
end
