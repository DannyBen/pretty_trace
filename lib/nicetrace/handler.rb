module Nicetrace
  class Handler
    include Colsole
    include Singleton

    def initialize
      @printed = false
    end
    
    def trace
      TracePoint.new :raise do |tp|
        exit 1 if @printed
        @printed = true

        e = tp.raised_exception

        nicetrace = e.backtrace

        nicetrace.reject! do |trace|
          trace =~ /(bin\/(run|ruby_executable_hooks)|lib\/runfile)/
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
        say "!txtred!#{e.message}"

        exit 1
      end
    end
  end
end