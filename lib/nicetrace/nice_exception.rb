module Nicetrace
  class NiceException
    attr_reader :exception, :config

    def initialize(exception, config=nil)
      @exception = exception
      @config = config || Config.instance
    end

    def messages
      backtrace = exception.backtrace

      if config.filter.is_a? Range
        backtrace = backtrace[config.filter]
        config.filter = []
      end

      config.filter.each do |expression|
        backtrace.reject! { |trace| trace =~ expression }
      end

      backtrace.map! do |item|
        if item =~ /([^\/]+\/)?([\w\d_\.]+):(\d+):in `(.+)'/
          dir, file, line, place = $1, $2, $3, $4
          item = "line !bldgrn!#{line.to_s.ljust 4}!txtrst! in !txtcyn!#{dir}!bldpur!#{file}!txtrst! > !txtblu!#{place}"
        end
        item
      end

      backtrace << "\n!undgrn!#{exception.class}"
      backtrace << "!txtred!#{exception.message}\n"

      backtrace
    end
  end
end