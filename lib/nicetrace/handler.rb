require 'colsole'

module Nicetrace
  class Handler
    extend Colsole
    include Singleton

    def config
      @config ||= config!
    end

    def config!
      {
        filter: []
      }
    end

    def trace_point
      @trace_point ||= trace_point!
    end

    def trace_point!
      TracePoint.new :raise do |tp|
        e = tp.raised_exception

        nicetrace = e.backtrace
        filter = config[:filter]

        filter.each do |expression|
          nicetrace.reject! { |trace| trace =~ expression }
        end

        nicetrace.map! do |item|
          if item =~ /([^\/]+\/)?([\w\d_\.]+):(\d+):in `(.+)'/
            dir, file, line, place = $1, $2, $3, $4
            item = "line !bldgrn!#{line.to_s.ljust 4}!txtrst! in !txtcyn!#{dir}!bldpur!#{file}!txtrst! > !txtblu!#{place}"
          end
          item
        end

        nicetrace.each do |line|
          say line
        end

        say "\n!undgrn!#{e.class}"
        say "!txtred!#{e.message}\n"
        
        trace_point.disable
        exit 1
      end
    end
  end
end