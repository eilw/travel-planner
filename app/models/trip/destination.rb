class Trip::Destination < ApplicationRecord
  belongs_to :trip
  has_many :comments, as: :commentable, dependent: :delete_all
  validates :name, presence: true
end
