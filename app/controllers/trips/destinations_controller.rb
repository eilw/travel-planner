class Trips::DestinationsController < ApplicationController
  before_action :authenticate_user!

  def new
    build_destination
  end

  def create
    build_destination
    save_destination || render(:new)
  end

  private

  def build_destination
    @destination ||= destination_scope.build
    @destination.attributes = destination_params
  end

  def save_destination
    redirect_to @trip if @destination.save
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
