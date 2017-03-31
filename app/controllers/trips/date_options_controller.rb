class Trips::DateOptionsController < ApplicationController
  before_action :authenticate_user!

  def new
    build_date
  end

  def create
    build_date
    save_date || render(:new)
  end

  private

  def build_date
    @date ||= date_scope.build
    @date.attributes = date_params
  end

  def save_date
    redirect_to @trip if @date.save
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
  end

  def date_scope
    trip.date_options
  end

  def date_params
    date_params = params[:trip_date_option]
    date_params ? date_params.permit(:range) : {}
  end
end
