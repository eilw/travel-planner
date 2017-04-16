class Trip::DateOption < ApplicationRecord
  belongs_to :trip
  belongs_to :creator, class_name: "TripParticipant"
  validates :range, presence: true
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :votes, as: :votable, dependent: :delete_all
end
