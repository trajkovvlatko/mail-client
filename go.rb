require 'rubygems'
require './include/Message'
require './include/Account'
require './include/Router'
require 'net/imap'
require 'net/smtp'
require 'mail'


account = Account.new

imap = account.connect

messages = account.fetch(imap)

if messages.length > 0
  Router.show(messages)
end
