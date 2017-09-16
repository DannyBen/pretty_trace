module Nicetrace
  def self.enable
    Handler.instance.trace_point.enable unless ENV['NICETRACE'] == 'off'
  end

  def self.filter=(filter)
    config.filter = filter.is_a?(Regexp) ? [filter] : filter
  end

  def self.filter
    config.filter
  end

  def self.config
    Config.instance
  end

end