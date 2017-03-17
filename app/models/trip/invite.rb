class Trip::Invite < ApplicationRecord
  has_secure_token

  belongs_to :trip

  validates :email, uniqueness: {
    scope: :trip_id,
    message: "has already been added as an invite"
  }
  validates :email, presence: true
  validates :email, format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create

  after_update :update_responded_at, if: :rvsp_changed?
  after_create :send_invite

  def responded?
    responded_at.present?
  end

  private

  def update_responded_at
    touch :responded_at
  end

  def send_invite
    mailer.send_new_invitation(self, trip).deliver_now
  end

  def mailer
    TripMailer
  end
end
