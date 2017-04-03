module VoteScoreHelper
  def for_vote_count(votes)
    votes.where(yay: true).count
  end

  def against_vote_count(votes)
    votes.where(nay: true).count
  end
end
