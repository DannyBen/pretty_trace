module PrettyTrace
  module Colors
    def colors
      {
        reset:   "\e[0m",
        bold:    "\e[1m",
        black:   "\e[30m",    black_bold:   "\e[1;30m",
        red:     "\e[31m",    red_bold:     "\e[1;31m",
        green:   "\e[32m",    green_bold:   "\e[1;32m",
        yellow:  "\e[33m",    yellow_bold:  "\e[1;33m",
        blue:    "\e[34m",    blue_bold:    "\e[1;34m",
        magenta: "\e[35m",    magenta_bold: "\e[1;35m",
        cyan:    "\e[36m",    cyan_bold:    "\e[1;36m",
        white:   "\e[37m",    white_bold:   "\e[1;37m",
      }
    end
  end
end
