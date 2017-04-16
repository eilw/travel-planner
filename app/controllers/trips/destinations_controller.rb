class Trips::DestinationsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: "Trip::Destination", only: :destroy

  def new
    build_destination
  end

  def create
    build_destination
    save_destination || render(:new)
  end

  def destroy
    trip = @destination.trip
    @destination.destroy
    redirect_to trip_path(trip)
  end

  private

  def build_destination
    @destination ||= destination_scope.build
    @destination.attributes = destination_params
    @destination.creator = trip_participant
  end

  def save_destination
    redirect_to @trip if @destination.save
  end

  def trip_participant
    @trip.trip_participants.where(user: current_user).first
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
  end

  def destination_scope
    trip.destinations
  end

  def destination_params
    destination_params = params[:trip_destination]
    destination_params ? destination_params.permit(:name, :description) : {}
  end
end
