class Trip::DateOption < ApplicationRecord
  belongs_to :trip
  validates :range, presence: true
end
