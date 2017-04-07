class TripParticipant < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_many :destinations, dependent: :destroy, class_name: "Trip::Destination", foreign_key: "creator_id"
  has_many :date_options, dependent: :destroy, class_name: "Trip::DateOption", foreign_key: "creator_id"
end
