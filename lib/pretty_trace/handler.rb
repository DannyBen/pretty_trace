module PrettyTrace
  class Handler
    class << self
      include Colors

      attr_writer :options

      def enable
        @enabled = true
        # :nocov: - this is actually covered through an external process
        at_exit do
          if @enabled && $! && !ignored.include?($!.class)
            show_errors $!
            $stderr.reopen IO::NULL
            $stdout.reopen IO::NULL
          end
        end
        # :nocov:
      end

      def disable
        @enabled = false
      end

      def enabled?
        @enabled
      end

      def debug_tip?
        !!(options[:debug_tip] and ENV['PRETTY_TRACE'] != 'full')
      end

      def options
        @options ||= default_options
      end

    private

      def ignored
        # :nocov:
        [SystemExit]
        # :nocov:
      end

      def show_errors(exception)
        # :nocov:
        backtrace = StructuredBacktrace.new exception.backtrace, options

        puts "\n#{backtrace}" unless backtrace.empty?

        message = exception.message
        puts "\n%{red}█ %{reset}%{bold}#{exception.class}%{reset}\n" % colors
        unless message.empty?
          puts "%{red}█ %{reset}%{yellow}#{message}%{reset}\n" % colors 
        end

        if debug_tip?
          puts "\nTip: Run with %{cyan}PRETTY_TRACE=full%{reset} (or %{cyan}off%{reset}) for debug information" % colors
        end

        $stdout.flush
        # :nocov:
      end

      def default_options
        { filter: [] }
      end
    end
  end
end
