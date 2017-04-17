module Optionable
  extend ActiveSupport::Concern

  included do
    belongs_to :creator, class_name: "TripParticipant"
    has_many :comments, as: :commentable, dependent: :destroy
    has_many :votes, as: :votable, dependent: :destroy
  end

  def vote_score
    votes.where(yay: true).count - votes.where(nay: true).count
  end
end
