require 'colsole'

module Nicetrace
  extend Colsole

  CONFIG = {
    filter: []
  }

  HANDLER = TracePoint.new :raise do |tp|
    e = tp.raised_exception

    nicetrace = e.backtrace
    filter = CONFIG[:filter]

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
    
    HANDLER.disable
    exit 1
  end

  def self.filter=(filter)
    CONFIG[:filter] = filter.is_a?(Array) ? filter : [filter]
  end
end