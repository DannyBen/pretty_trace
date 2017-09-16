module PrettyTrace
  def self.enable
    Handler.instance.trace_point.enable unless ENV['NICETRACE'] == 'off'
  end

  def self.filter(filter)
    config.filter << filter
  end

  def self.range(range)
    config.range = range
  end

  def self.ignore(exception_class)
    config.ignore << exception_class
  end

  def self.config
    Config.instance
  end

end