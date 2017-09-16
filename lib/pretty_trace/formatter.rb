module PrettyTrace
  class Formatter
    def self.pretty_trace(backtrace, opts={})
      filter = opts[:filter] || []
      filter = [filter] unless filter.is_a? Array

      filter.each do |expression|
        backtrace.reject! { |trace| trace =~ expression }
      end

      backtrace.map! do |item|
        if item =~ /(.+):(\d+):in `(.+)'/
          file, line, method = $1, $2, $3
          dir = File.dirname(file).split('/').last
          dir = dir == '.' ? '' : "#{dir}/"

          file = File.basename file
          item = "line %{green}#{line.to_s.ljust 4}%{reset} in %{cyan}#{dir}%{magenta}#{file}%{reset} > %{blue}#{method}%{reset}" % colors
        end
        item
      end

      backtrace
    end

    def self.colors
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