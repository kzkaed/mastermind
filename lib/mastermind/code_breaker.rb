module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader  :color_count
    attr_accessor :guess_color_index, :count_color_index

    COLORS = %w(Red Yellow Blue Green Black White)


    def initialize
      @guess_number = 0
      @guess_color_index = 0
      @count_color_index = 0

      @permutations = []

      @color_count = {
          "Red" => 0,
          "Yellow" => 0,
          "Blue" => 0,
          "Green" => 0,
          "Black" => 0,
          "White" => 0
      }

    end

    def guess(response)
      response = ["", "", "", ""] if response == []
      guess = []

      if @guess_number <= 6
        if @guess_number == 0
          guess = make_solid_color_guess(color_for_guess)
        elsif @guess_number < 6 && @guess_number > 0
          count_colors(response, color_to_count)
          guess = make_solid_color_guess(color_for_guess)
        elsif @guess_number == 6
          count_colors(response, color_to_count)
          fine_just_use_list
          guess = make_guess_from_permutations(response)
        end
        @guess_number = @guess_number + 1
      else
        guess = make_guess_from_permutations(response)
      end

      guess
    end

    def color_for_guess
      color = COLORS[@guess_color_index]
      @guess_color_index = @guess_color_index + 1

      color
    end

    def color_to_count
      color = COLORS[@count_color_index]
      @count_color_index = @count_color_index + 1

      color
    end

    def count_colors(response, color)
      response.each do |peg|
        if peg == "Black" || peg == "White"
          @color_count[color] = plus_one(@color_count[color])
        end
      end

      @color_count
    end

    def make_solid_color_guess(color)
      [color, color, color, color]
    end

    def fine_just_use_list
      @permutations = possible_colors.permutation.to_a
    end

    def make_guess_from_permutations(response)
      guess = ["","","",""]

      if response != ["Black","Black","Black","Black"]
        guess = @permutations.pop
      end

      guess
    end

    def possible_colors
      color_array = []

      @color_count.each do |color, occurrence|
         if occurrence > 0
           count = get_color_count(color)
           count.times do
            color_array << color
           end
         end
       end

      color_array
    end

    def get_color_count(color)
      @color_count.each { |key, value| return value if key == color }
    end


    private

    def plus_one (value)
      value + 1
    end




  end
end