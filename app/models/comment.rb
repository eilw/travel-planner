class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
  validates :text, presence: true
  after_create :add_timestamp

  private

  def add_timestamp
    touch :added_at
  end
end
