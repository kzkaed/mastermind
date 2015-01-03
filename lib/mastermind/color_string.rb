

module Mastermind

  class ColorString
    def color(text, color_code)
      "#{color_code}#{text}\033[0m"
    end

    def black(text); color(text, "\033[30;47m"); end
    def red(text); color(text, "\033[31m"); end
    def green(text); color(text, "\033[32m"); end
    def yellow(text); color(text, "\033[33m"); end
    def blue(text); color(text, "\033[34m"); end
    def white(text); color(text, "\033[37;40m"); end

    def white_black(text); color(text, "\033[37;40m"); end
    def black_white(text); color(text, "\033[30;47m"); end
    def red_white(text); color(text, "\033[31;47m"); end
    def green_white(text); color(text, "\033[32;47m"); end
    def yellow_white(text); color(text, "\033[33;47m"); end
    def blue_white(text); color(text, "\033[34;47m"); end

    def magenta(text); color(text, "\033[35m"); end
  end

end

#### ANSI Escape Sequences
#### Example
# ESC[1;33;44m
# bright yellow text on blue

#####
# 0	Turn off all attributes
# 1	Set bright mode
# 4	Set underline mode
# 5	Set blink mode
# 7	Exchange foreground and background colors
# 8	Hide text (foreground color would be the same as background)
#
# 30	Black text
# 31	Red text
# 32	Green text
# 33	Yellow text
# 34	Blue text
# 35	Magenta text
# 36	Cyan text
# 37	White text
# 39	Default text color
# 40	Black background
# 41	Red background
# 42	Green background
# 43	Yellow background
# 44	Blue background
# 45	Magenta background
# 46	Cyan background
# 47	White background
# 49	Default background color