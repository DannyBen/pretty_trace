require 'colsole'
require 'singleton'

module PrettyTrace
  class Handler
    extend Colsole
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
          exception.messages.each { |line| say line }

          trace_point.disable
          exit 1
        end
      end
    end

    def config
      Config.instance
    end
  end
end