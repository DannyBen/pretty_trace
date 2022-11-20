module PrettyTrace
  class << self
    def enable
      Handler.enable unless ENV['PRETTY_TRACE'] == 'off'
    end

    def disable
      Handler.disable
    end

    def filter(filter)
      if filter.is_a? Array
        Handler.options[:filter] += filter
      else
        Handler.options[:filter] << filter
      end
    end

    def debug_tip
      Handler.options[:debug_tip] = true
    end

    def no_debug_tip
      Handler.options[:debug_tip] = false
    end

    def trim
      Handler.options[:trim] = true
    end

    def no_trim
      Handler.options[:trim] = false
    end
  end
end
