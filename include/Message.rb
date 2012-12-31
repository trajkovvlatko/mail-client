class Message
  attr_accessor :id, :subject, :content, :from, :to, :sent_on
  def initialize(id, subject, content, from, to, sent_on)
    self.id = id
    self.subject = subject
    self.content = content
    self.from = from
    self.to = to
    self.sent_on = sent_on
  end

  def self.set(emails)
    messages= []
    emails.each_with_index do |email, id|
      id = id + 1
      message = Message.new(id, email.subject, email.text_part.body.to_s, email.from, email.to, email.date.to_s)
      messages << message
    end
    messages
  end

end
