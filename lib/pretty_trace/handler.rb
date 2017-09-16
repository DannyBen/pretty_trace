require 'singleton'

module PrettyTrace
  class Handler
    include Singleton

    def trace_point
      @trace_point ||= trace_point!
    end

    private

    def trace_point!
      TracePoint.new :raise do |tp|
        raised_exception = tp.raised_exception
        unless config.ignore.include? raised_exception.class
          exception = PrettyException.new raised_exception
          raised_exception.set_backtrace exception.messages
        end
      end
    end

    def config
      Config.instance
    end
  end
end