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

  def self.reply(m, messages)
    system("clear")
    puts m.subject
    puts m.content
    puts "Reply: "
    reply = gets.chomp
    puts "Send mail to " + m.from.to_s + "? (y/n) "
    confirm = gets.chomp
    if confirm == "y"
      a = Account.new
      smtp = Net::SMTP.new a.smtp, a.smtp_port
      smtp.enable_starttls
      smtp.start(a.domain, a.mail, a.password, :login) do
        smtp.send_message(reply, a.mail, m.from)
      end
    end
    show(messages)
  end

  def self.show(messages)
    system("clear");
    puts "*****************************************************************"
    messages.each do |message|
      puts message.id.to_s + ". " + message.subject + " from " + message.from.to_s
    end
    puts "*****************************************************************"
    key = gets.chomp
    if key.empty?
    else
      read(key.to_i, messages)
    end
  end

  def self.read(message_id, messages)
    m = messages[message_id -1]
    puts "\n"
    puts "Subject: " + ". " + m.subject
    puts "From: " + m.from.to_s
    puts "Sent on: " + m.sent_on.to_s
    puts "\n"
    puts m.content
    puts "\n\n"
    puts "Type r to reply"
    puts "Type m for mail list"
    key = gets.chomp
    if key.empty?
      #end program
    else
      case(key)
        when "r"
          reply(m, messages)
        when "m"
          show(messages)
      end
    end
  end

end
