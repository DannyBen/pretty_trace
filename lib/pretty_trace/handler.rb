require 'singleton'

module PrettyTrace
  class Handler
    include Singleton
    include Colors

    def enable
      @enabled = true
      at_exit do
        if @enabled and $! and !ignored.include? $!.class
          show_errors $!
          exit!
        end
      end
    end

    def disable
      @enabled = false
    end

    def enabled?
      @enabled
    end

    def options
      @options ||= default_options
    end

    def options=(new_options)
      @options = new_options
    end

    private

    def ignored
      [ SystemExit ]
    end

    def show_errors(exception)
      backtrace = StructuredBacktrace.new exception.backtrace, options
      puts "\n#{backtrace}"
      message = exception.message
      if message.empty?
        puts "\n%{blue}#{exception.class}%{reset}\n" % colors
      else
        puts "\n%{blue}#{exception.class}\n%{red}#{message}%{reset}\n" % colors
      end
    end

    def default_options
      { filter: [] }
    end
  end
end;