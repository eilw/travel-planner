class TripsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    load_trips
  end

  def new
    build_trip
  end

  def show
    load_trip
  end

  def create
    build_trip
    save_trip || render(:new)
  end

  def destroy
    load_trip
    @trip.destroy!

    redirect_to trips_path
  end

  private

  def load_trips
    @trips ||= trip_scope.to_a
  end

  def load_trip
    @trip ||= trip_scope.find(params.fetch(:id))
  end

  def build_trip
    @trip ||= trip_scope.build
    @trip.attributes = trip_params
    @trip.organiser = current_user
  end

  def save_trip
    redirect_to @trip if @trip.save
  end

  def trip_scope
    current_user.trips
  end

  def trip_params
    trip_params = params[:trip]
    trip_params ? trip_params.permit(:name, :description) : {}
  end
end
