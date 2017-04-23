class Trip::ParticipantBuilder < ActiveType::Object
  attribute :emails, :text
  attribute :message, :text
  attribute :trip_id

  validates :emails, presence: true

  before_save :process_participants

  def save
    super
    invalid_emails.empty?
  end

  private

  def process_participants
    email_list = unique_emails_in_trip
    email_list.each do |email|
      create_participant(email)
    end

    return_invalid_emails
  end

  def create_participant(email)
    if valid_email?(email)
      user = find_or_create_user(email)
      participant_scope << user
    else
      invalid_emails << email
      errors.add(:emails, "#{email} is not a valid email")
    end
  end

  def find_or_create_user(email)
    User.find_by(email: email) || User.invite!(email: email, username: email)
  end

  def valid_email?(email)
    email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
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
    parser.list_of_emails(emails).uniq.reject { |email| already_participating?(email) }
  end

  def already_participating?(email)
    participant_scope.exists?(email: email)
  end

  def parser
    EmailParser
  end

  def participant_scope
    trip.participants
  end

  def trip
    @trip ||= Trip.find(trip_id)
  end
end
