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
          item = "line %{green}#{line.to_s.ljust 4}%{reset} in %{cyan}#{dir}%{magenta}#{file}%{reset} > %{blue}#{place}%{reset}" % colors
        end
        item
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

    def colors
      @colors ||= colors!
    end

    def colors!
      esc = 27.chr
      {
        reset:  "#{esc}[0m",
        black:  "#{esc}[30m",
        red:    "#{esc}[31m",
        green:  "#{esc}[32m",
        yellow: "#{esc}[33m",
        blue:   "#{esc}[34m",
        magenta:"#{esc}[35m",
        cyan:   "#{esc}[36m",
        white:  "#{esc}[37m",
      }
    end
  end
end