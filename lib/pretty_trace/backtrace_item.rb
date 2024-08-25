module PrettyTrace
  class BacktraceItem
    include Colors

    attr_reader :original_line, :path, :file, :line, :dir, :method, :full_dir

    def initialize(original_line)
      @original_line = original_line
      @formatted = false

      return unless @original_line =~ /(.+):(-?\d+):in `(.+)'/

      @formatted = true
      @path = $1
      @line = $2
      @method = $3
      @full_dir = File.dirname(@path)
      @dir = @full_dir.split('/').last
      @dir = @dir == '.' ? '' : "#{dir}/"
      @file = File.basename @path
    end

    def formatted?
      @formatted
    end

    def formatted_line
      formatted? ? colored_line : original_line
    end

    def colored_line
      "line %{green_bold}#{line.to_s.ljust 4}%{reset} in %{cyan}#{dir}%{magenta}#{file}%{reset} > %{blue}#{method}%{reset}" % colors
    end
  end
end
