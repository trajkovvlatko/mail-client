require 'rubygems'
require './include/Message'
require './include/Account'
require 'net/imap'
require 'net/smtp'
require 'mail'

def main
  account = Account.new
  imap = account.connect

  messages = account.fetch(imap)
  if messages.length > 0
    Message.show(messages)
  end
end

main

