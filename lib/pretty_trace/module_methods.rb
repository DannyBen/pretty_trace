module PrettyTrace
  def self.enable
    Handler.instance.trace_point.enable unless ENV['PRETTY_TRACE'] == 'off'
  end

  def self.disable
    Handler.instance.trace_point.disable
  end

  def self.filter(filter)
    if filter.is_a? Array
      Handler.instance.options[:filter] += filter
    else
      Handler.instance.options[:filter] << filter
    end
  end
end