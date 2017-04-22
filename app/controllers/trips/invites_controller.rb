class Trips::InvitesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: "Trip::Invite", only: [:update, :destroy]

  def new
    build_invite_builder
  end

  def create
    build_invite_builder

    if @invite_builder.save
      redirect_to new_trip_invite_path
    else
      render(:new)
    end
  end

  def update
    @invite.update(invite_rvsp_params)
    redirect_to trips_path
  end

  def destroy
    trip = @invite.trip
    @invite.destroy

    redirect_to new_trip_invite_path(trip)
  end

  private

  def build_invite_builder
    trip
    @invite_builder ||= Trip::InviteBuilder.new(invite_params)
  end

  def invite_scope
    Trip::Invite.all
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
    authorize! :read, @trip
  end

  def invite_rvsp_params
    params.require(:trip_invite).permit(:rvsp)
  end

  def invite_params
    invite_params = params[:trip_invite_builder]
    if invite_params
      invite_params[:trip_id] = params[:trip_id]
      invite_params.permit(:emails, :message, :trip_id)
    else
      {}
    end
  end
end
