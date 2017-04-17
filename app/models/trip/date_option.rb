class Trip::DateOption < ApplicationRecord
  include Optionable
  belongs_to :trip
  validates :range, presence: true
end
