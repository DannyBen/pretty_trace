module Nicetrace
  def self.enable
    Handler.instance.trace_point.enable unless ENV['NICETRACE'] == 'off'
  end

  def self.filter=(filter)
    Handler.instance.config[:filter] = filter.is_a?(Array) ? filter : [filter]
  end

  def self.filter
    Handler.instance.config[:filter]
  end
end