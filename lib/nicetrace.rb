require 'nicetrace/version'
require 'nicetrace/handler'

module Nicetrace
  def self.enable
    @enabled = true
    Handler.instance.trace.enable
  end

  def self.disable
    Handler.instance.trace.disable
    @enabled = false
  end
end