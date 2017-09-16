require 'ostruct'

module PrettyTrace
  class PrettyException
    attr_reader :source, :config

    def initialize(source, opts=nil)
      @source = source
      @config = opts ? Config.from_hash(opts) : Config.instance
    end

    def messages
      pretty_trace = backtrace

      config.filter.each do |expression|
        pretty_trace.reject! { |trace| trace =~ expression }
      end

      pretty_trace = pretty_trace[config.range] if config.range

      pretty_trace.map! do |item|
        if item =~ /([^\/]+\/)?([\w\d_\.]+):(\d+):in `(.+)'/
          dir, file, line, place = $1, $2, $3, $4
          item = "line !bldgrn!#{line.to_s.ljust 4}!txtrst! in !txtcyn!#{dir}!bldpur!#{file}!txtrst! > !txtblu!#{place}"
        end
        item
      end

      if source.respond_to?(:message)
        pretty_trace << "\n" 
        pretty_trace << "!undgrn!#{source.class}" 
        pretty_trace << "!txtred!#{source.message}"
        pretty_trace << "\n" 
      end

      pretty_trace
    end

    private

    def backtrace
      if source.respond_to?(:backtrace)
        source.backtrace.respond_to?(:[]) ? source.backtrace : []
      else
        source
      end
    end
  end
end