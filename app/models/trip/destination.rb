class Trip::Destination < ApplicationRecord
  include Optionable
  belongs_to :trip
  validates :name, presence: true
end
