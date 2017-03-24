class Alternatives::VotesController < ApplicationController
  before_action :authenticate_user!

  def vote_for
    build_vote
    @vote.for
    @vote.save

    render_voting_score
  end

  def vote_against
    build_vote
    @vote.against
    @vote.save

    render_voting_score
  end

  private

  def render_voting_score
    render action: 'voting_score'
  end

  def build_vote
    @vote ||= voted? ? vote_scope.first : vote_scope.build
  end

  def voted?
    !vote_scope.empty?
  end

  def vote_scope
    destination.votes.where(voter: current_user)
  end

  def destination
    @destination ||= Trip::Destination.find(params[:id])
  end
end
