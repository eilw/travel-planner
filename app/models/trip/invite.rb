class Trip::Invite < ApplicationRecord
  belongs_to :trip
  validates :email, uniqueness: {
    scope: :trip_id,
    message: "has already been added as an invite"
  }
  validates :email, presence: true
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create
end
