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
        if item =~ /(.+):(\d+):in `(.+)'/
          file, line, method = $1, $2, $3
          dir = File.dirname(file).split('/').last
          dir = dir == '.' ? '' : "#{dir}/"

          file = File.basename file
          item = "line %{green}#{line.to_s.ljust 4}%{reset} in %{cyan}#{dir}%{magenta}#{file}%{reset} > %{blue}#{method}%{reset}" % colors
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
      {
        reset:  "\e[0m",
        black:  "\e[30m",
        red:    "\e[31m",
        green:  "\e[32m",
        yellow: "\e[33m",
        blue:   "\e[34m",
        magenta:"\e[35m",
        cyan:   "\e[36m",
        white:  "\e[37m",
      }
    end
  end
end