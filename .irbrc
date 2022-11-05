require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = "#{Dir.home}/.irb-history"

require "awesome_print"
AwesomePrint.irb! # just in .irbrc

# ~/.aprc file.
AwesomePrint.defaults = {
  :indent => -2,
  :color => {
    :hash  => :pale,
    :class => :white
  }
}
