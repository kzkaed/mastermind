module Mastermind

  class Pegs
    attr_reader :red, :blue, :yellow, :green, :white, :black, :empty
    attr_reader :color, :color_pegs, :key_pegs
    def initialize

      color = ColorString.new#strings are output specific to console
      @red = color.red('Red')
      @blue = color.blue('Blue')
      @green = color.green('Green')
      @yellow = color.yellow('Yellow')
      @black = color.black('Black')
      @white = color.white('White')
      @empty = "o"

    end


    def console_color_pegs

      @color_pegs = {
          'Red' => @red,
          'Yellow' => @yellow,
          'Blue' => @blue,
          'Green' => @green,
          'Black' => @black,
          'White' => @white
      }
    end

    def console_key_pegs

      @key_pegs = {
          'Black' => @black,
          'White' => @white,
          '' => @empty
      }
    end



  end
end

