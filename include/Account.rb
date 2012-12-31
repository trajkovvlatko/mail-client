class Account

  attr_accessor :mail, :password, :server, :port, :ssl, :smtp, :smtp_port, :domain

  def initialize(server = "imap.gmail.com", port = "993",
                 mail = "mail@mail.com", password = "password",
                 ssl = true, smtp = "smtp.gmail.com", smtp_port = 587, domain = "gmail.com")
    self.server = server
    self.port = port
    self.mail = mail
    self.password = password
    self.ssl = ssl
    self.smtp = smtp
    self.smtp_port = smtp_port
    self.domain = domain
  end

  def connect
    imap = Net::IMAP.new(self.server, self.port, self.ssl)
    imap.login(self.mail, self.password)
    imap
  end

  def fetch(imap)
    emails = []
    imap.select("INBOX")
    unseen = imap.search(["UNSEEN"])
    if unseen.length > 0
      unseen.each do |emailId|
        m = imap.fetch(emailId, "RFC822")[0].attr["RFC822"]
        mail = Mail.new(m)
        emails << mail
      end
    else
      puts "No new mail."
    end
    messages = Message.set(emails)
    messages
  end
end
