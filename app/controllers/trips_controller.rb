class TripsController < ApplicationController
  before_action :authenticate_user!

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

  private

  def load_trips
    @trips ||= trip_scope.to_a
  end

  def load_trip
    @trip ||= trip_scope.find(params[:id])
  end

  def build_trip
    @trip ||= trip_scope.build
    @trip.attributes = trip_params
  end

  def save_trip
    redirect_to @trip if @trip.save!
  end

  def trip_scope
    Trip.where(creator: current_user)
  end

  def trip_params
    trip_params = params[:trip]
    trip_params ? trip_params.permit(:name, :description) : {}
  end
end
