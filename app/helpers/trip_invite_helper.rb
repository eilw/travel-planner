module TripInviteHelper
  def rvsp_state(invite)
    return "Pending" unless invite.responded?

    if invite.rvsp
      "Accepted"
    else
      "Declined"
    end
  end
end
