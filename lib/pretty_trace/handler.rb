require 'singleton'

module PrettyTrace
  class Handler
    include Singleton

    def trace_point
      @trace_point ||= trace_point!
    end

    def options
      @options ||= default_options
    end

    def options=(new_options)
      @options = new_options
    end

    private

    def trace_point!
      TracePoint.new :raise do |tp|
        exception = tp.raised_exception
        backtrace = exception.backtrace
        pretty_trace = Formatter.pretty_trace backtrace, options
        exception.set_backtrace pretty_trace
      end
    end

    def default_options
      { filter: [] }
    end
  end
end