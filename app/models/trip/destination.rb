class Trip::Destination < ApplicationRecord
  belongs_to :trip
  belongs_to :creator, class_name: "TripParticipant"
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates :name, presence: true
end
