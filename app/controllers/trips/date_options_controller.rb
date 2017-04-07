class Trips::DateOptionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: "Trip::DateOption", only: :destroy

  def new
    build_date
  end

  def create
    build_date
    save_date || render(:new)
  end

  def destroy
    trip = @date_option.trip
    @date_option.destroy
    redirect_to trip_path(trip)
  end

  private

  def build_date
    @date ||= date_scope.build
    @date.attributes = date_params
    @date.creator = trip_participant
  end

  def save_date
    redirect_to @trip if @date.save
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
  end

  def trip_participant
    @trip.trip_participants.where(user: current_user).first
  end

  def date_scope
    trip.date_options
  end

  def date_params
    date_params = params[:trip_date_option]
    date_params ? date_params.permit(:range) : {}
  end
end
