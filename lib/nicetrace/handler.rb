module Nicetrace
  class Handler
    extend Colsole

    HANDLER = TracePoint.new :raise do |tp|
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
    end
  end
end