class Trip::InviteBuilder < ActiveType::Object
  attribute :emails, :text
  attribute :message, :text
  attribute :trip_id

  validates :emails, presence: true

  before_save :process_invites

  def save
    super
    invalid_emails.empty?
  end

  private

  def process_invites
    email_list = unique_emails_in_trip
    email_list.each do |email|
      create_invite(email)
    end

    return_invalid_emails
  end

  def create_invite(email)
    invite = invite_scope.build(email: email, message: message)
    store_invalid_invites(email, invite) unless invite.save
  end

  def store_invalid_invites(email, invite)
    invalid_emails << email
    errors.add(:emails, invite.errors.full_messages.join(', '))
  end

  def return_invalid_emails
    self.emails = invalid_emails_combined
  end

  def invalid_emails_combined
    invalid_emails.join(', ')
  end

  def invalid_emails
    @invalid_emails ||= []
  end

  def unique_emails_in_trip
    parser.list_of_emails(emails).uniq.reject { |email| already_invited?(email) }
  end

  def already_invited?(email)
    invite_scope.exists?(email: email)
  end

  def parser
    EmailParser
  end

  def invite_scope
    trip.invites
  end

  def trip
    @trip ||= Trip.find(trip_id)
  end
end
