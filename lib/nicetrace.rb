require 'nicetrace/version'
require 'nicetrace/handler'

module Nicetrace
  def self.enable
    Handler.instance.trace_point.enable
  end

  def self.disable
    Handler.instance.trace_point.enable
  end

  def self.filter=(filter)
    Handler.instance.config[:filter] = filter.is_a?(Array) ? filter : [filter]
  end

end