class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    build_vote
    @vote.choice(params[:vote])

    render_voting_score
  end

  private

  def render_voting_score
    render action: 'voting_score' if @vote.save
  end

  def build_vote
    @vote ||= voted? ? vote_scope.first : vote_scope.build
  end

  def voted?
    !vote_scope.empty?
  end

  def vote_scope
    votable.votes.where(voter: current_user)
  end

  def votable
    klass = params[:votable_type].camelize.constantize
    @votable ||= klass.find(params[:votable_id])
  end
end
