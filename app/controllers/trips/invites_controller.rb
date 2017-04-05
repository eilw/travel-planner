class Trips::InvitesController < ApplicationController
  before_action :authenticate_user!, except: :rvsp

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

  def destroy
    invite = invite_scope.find(params.fetch(:id))
    authorize! :destroy, invite

    trip = invite.trip
    invite.destroy

    redirect_to new_trip_invite_path(trip)
  end

  def rvsp
    invite = invite_scope.find_by(token: params[:token])
    if invite.update!(rvsp: params[:rvsp]) && invite.rvsp
      flash[:notice] = 'Thanks for your response'
      redirect_to(trip_path(invite.trip))
    else
      redirect_to root_path
    end
  end

  private

  def build_invite_builder
    trip
    @invite_builder ||= Trip::InviteBuilder.new(invite_params)
  end

  def build_invite
    @invite = trip_invite_scope.build
  end

  def invite_scope
    Trip::Invite.all
  end

  def trip_invite_scope
    trip.invites
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
    authorize! :read, @trip
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
