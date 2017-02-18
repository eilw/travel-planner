class Trip::Invite < ApplicationRecord
  belongs_to :trip
  validates :email, presence: true
end
