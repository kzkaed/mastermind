module Mastermind

  class ColorPegs
    attr_reader :red, :blue, :yellow, :green, :white, :black
    def initialize
      color = ColorString.new
      @red = color.red('Red')
      @blue = color.blue('Blue')
      @green = color.green('Green')
      @yellow = color.yellow('Yellow')
      @black = color.black('Black')
      @white = color.white('White')
    end


  end
end

