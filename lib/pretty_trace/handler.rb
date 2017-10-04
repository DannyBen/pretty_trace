require 'singleton'

module PrettyTrace
  class Handler
    include Singleton
    include Colors

    def enable
      @enabled = true
      at_exit do
        if @enabled and $!
          show_errors $!
          exit!
        end
      end
    end

    def disable
      @enabled = false
    end

    def options
      @options ||= default_options
    end

    def options=(new_options)
      @options = new_options
    end

    private

    def show_errors(exception)
      puts formatter.pretty_trace exception.backtrace, options
      message = exception.message
      message = "No message given" if message.empty?
      puts "\n%{red}#{message}%{reset}\n" % colors
    end

    def default_options
      { filter: [] }
    end

    def formatter
      Formatter.instance
    end
  end
end;