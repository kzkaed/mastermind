

module Mastermind

  class Color

      def black(string_to_color)
        "\033[30m#{string_to_color}\033[0m"
      end

      def red(string_to_color)
        "\033[31m#{string_to_color}\033[0m"
      end

      def magenta(string_to_color)
        "\33[35m#{string_to_color}\033[0m"
      end
  end
=begin
  class String

    def colorize(color_code)
      "\e[#{color_code}m#{self}\e[0m"
    end

    def red
      colorize(31)
    end

    def green
      colorize(32)
    end

    def yellow
      colorize(33)
    end


  end
=end
end