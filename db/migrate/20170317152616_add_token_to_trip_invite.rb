class AddTokenToTripInvite < ActiveRecord::Migration[5.0]
  def change
    add_column :trip_invites, :token, :string
    add_index :trip_invites, :token, unique: true
  end
end
