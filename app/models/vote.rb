class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true
  belongs_to :voter, class_name: "User"
  validates :voter, uniqueness: { scope: [:votable_type, :votable_id] }
  validate :cannot_vote_for_and_against

  def choice(vote)
    vote_for if vote == 'for'
    vote_against if vote == 'against'
  end

  private

  def vote_for
    ActiveRecord::Base.transaction do
      update!(nay: false) unless yay && !nay
      toggle(:yay)
    end
  end

  def vote_against
    ActiveRecord::Base.transaction do
      update!(yay: false) unless nay && !yay
      toggle(:nay)
    end
  end

  def cannot_vote_for_and_against
    errors.add(:yay, "Cannot vote for both at the same time") if yay && nay
  end
end
