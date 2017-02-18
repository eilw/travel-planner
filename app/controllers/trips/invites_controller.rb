class Trips::InvitesController < ApplicationController
  before_action :authenticate_user!
  def new
    build_invite
  end

  def create
    build_invite
    save_invite || render(:new)
  end

  private

  def build_invite
    @invite ||= invite_scope.build
    @invite.attributes = invite_params
  end

  def save_invite
    redirect_to @trip if @invite.save
  end

  def invite_scope
    trip.invites
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
  end

  def invite_params
    invite_params = params[:trip_invite]
    invite_params ? invite_params.permit(:email) : {}
  end
end
