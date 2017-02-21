class EmailParser
  def self.list_of_emails(emails)
    return [] unless emails

    emails.split(/\s*,\s*/)
  end
end
