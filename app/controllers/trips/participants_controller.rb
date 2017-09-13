class Trips::ParticipantsController < ApplicationController
  before_action :authenticate_user!

  def new
    build_participant_builder
  end

  def create
    build_participant_builder

    if @participant_builder.save
      redirect_to new_trip_participant_path
    else
      render(:new)
    end
  end

  private

  def build_participant_builder
    trip
    @participant_builder ||= Trip::ParticipantBuilder.new(participant_params)
  end

  def trip
    @trip ||= Trip.find(params[:trip_id])
    authorize! :read, @trip
  end

  def participant_params
    participant_params = params[:trip_participant_builder]
    if participant_params
      participant_params[:trip_id] = params[:trip_id]
      participant_params.permit(:emails, :message, :trip_id)
    else
      {}
    end
  end
end
