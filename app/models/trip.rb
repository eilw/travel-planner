class Trip < ApplicationRecord
  validates :name, presence: true
  belongs_to :organiser, class_name: "User", foreign_key: "user_id"
  has_many :trip_participants
  has_many :participants, through: :trip_participants, source: :user
  has_many :invites
  after_create :organiser_is_a_participant

  private

  def organiser_is_a_participant
    participants << organiser
  end
end
