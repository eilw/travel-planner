require "rails_helper"

describe EmailParser do
  let(:parser) { described_class }

  describe '.list_of_emails' do
    it 'returns an array of emails from input string split by ,' do
      input = 'test@email.com, test2@email.com'
      output = ['test@email.com', 'test2@email.com']
      expect(parser.list_of_emails(input)).to eq(output)
    end

    it 'deals with missing whitespace' do
      input = 'test@email.com   , test2@email.com'
      output = ['test@email.com', 'test2@email.com']
      expect(parser.list_of_emails(input)).to eq(output)
    end

    it 'defaults empty array if no emails are passed' do
      expect(parser.list_of_emails(nil)).to eq([])
    end
  end
end
