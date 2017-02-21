class Trips::InvitesController < ApplicationController
  before_action :authenticate_user!
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

  private

  def build_invite_builder
    trip
    @invite_builder ||= Trip::InviteBuilder.new(invite_params)
  end

  def build_invite
    @invite = invite_scope.build
  end

  def invite_scope
    trip.invites
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
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
