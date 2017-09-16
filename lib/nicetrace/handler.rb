require 'colsole'

module Nicetrace
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

        exception = NiceException.new raised_exception
        exception.messages.each { |line| say line }

        trace_point.disable
        exit 1
      end
    end
  end
end