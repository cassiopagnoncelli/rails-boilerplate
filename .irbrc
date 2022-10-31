require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-history"

require "awesome_print"
AwesomePrint.irb! # just in .irbrc
