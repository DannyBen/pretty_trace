require 'nicetrace/version'
require 'nicetrace/handler'

module Nicetrace
  def self.enable
    HANDLER.enable
  end

  def self.disable
    HANDLER.enable
  end
end