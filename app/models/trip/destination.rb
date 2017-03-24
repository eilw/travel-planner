class Trip::Destination < ApplicationRecord
  belongs_to :trip
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :votes, as: :votable, dependent: :delete_all
  validates :name, presence: true

  def votes_for
    votes.where(yay: true).count
  end

  def votes_against
    votes.where(nay: true).count
  end
end
