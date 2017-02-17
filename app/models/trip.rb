class Trip < ApplicationRecord
  validates :name, presence: true
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
end
