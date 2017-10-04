module PrettyTrace
  class BacktraceItem
    attr_reader :original_line, :path, :file, :line, :dir, :method, :full_dir

    def initialize(original_line)
      @original_line = original_line
      @path, @file, @line, @dir, @full_dir = nil, nil, nil, nil, nil
      @formatted = false

      if @original_line =~ /(.+):(-?\d+):in `(.+)'/
        @formatted = true
        @path, @line, @method = $1, $2, $3
        @full_dir = File.dirname(@path)
        @dir = @full_dir.split('/').last
        @dir = @dir == '.' ? '' : "#{dir}/"
        @file = File.basename @path
      end
    end

    def formatted?
      @formatted
    end

    def formatted_line
      formatted? ? colored_line : original_line
    end

    def colored_line
      "line %{green}#{line.to_s.ljust 4}%{reset} in %{cyan}#{dir}%{magenta}#{file}%{reset} > %{blue}#{method}%{reset}" % colors
    end

    private

    def colors
      {
        reset:  "\e[0m",  black:  "\e[30m", red:    "\e[31m",
        green:  "\e[32m", yellow: "\e[33m", blue:   "\e[34m",
        magenta:"\e[35m", cyan:   "\e[36m", white:  "\e[37m",
      }
    end

  end
end
