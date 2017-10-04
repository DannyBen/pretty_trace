module PrettyTrace
  def self.enable
    Handler.instance.enable unless ENV['PRETTY_TRACE'] == 'off'
  end

  def self.disable
    Handler.instance.disable
  end

  def self.filter(filter)
    if filter.is_a? Array
      Handler.instance.options[:filter] += filter
    else
      Handler.instance.options[:filter] << filter
    end
  end

  def self.trim
    ENV['PRETTY_TRACE_TRIM'] = '1'
  end

  def self.no_trim
    ENV['PRETTY_TRACE_TRIM'] = nil
  end
end