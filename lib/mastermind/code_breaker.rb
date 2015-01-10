module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response, :color_count, :answer
    attr_accessor :guess_color_index, :count_color_index, :guess_index, :answer_index

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

      @index_of_guess = 0
      @answer = [nil, nil, nil, nil]

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

    def make_solid_color_guess(color)
      [color, color, color, color]
    end

    def make_guess_from_permutations(response)
      guess = ["","","",""]

      if response != ["Black","Black","Black","Black"]
        guess = @permutations.pop
      end

      guess
    end

    def fine_just_use_list
      @permutations = possible_colors.permutation.to_a
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

    def placeholder
      color = nil

      @color_count.each do |key, value|
        if value == 0
          color = key
        end
      end

      @placeholder ||= color
    end

    def get_color_count(color)
      @color_count.each { |key, value| return value if key == color }
    end

    def count_colors(response, color)
      response.each do |peg|
        if peg == "Black" || peg == "White"
          @color_count[color] = plus_one(@color_count[color])
        end
      end

      @color_count
    end

    def plus_one (value)
      value + 1
    end

    def make_combination_guess(response)
      guess = [placeholder, placeholder, placeholder, placeholder]

      if response.include?("Black")
        @answer[@index_of_guess - 1] = first_unplaced_color
        @color_count[first_unplaced_color] = @color_count[first_unplaced_color] - 1
        @index_of_guess = 0
        guess[@index_of_guess] = first_unplaced_color
      else
        guess[@index_of_guess] = first_unplaced_color
      end
      @index_of_guess = @index_of_guess + 1

      return guess if @answer.any? {|a| a.nil?}
      return @answer
    end

    def first_unplaced_color
      @color_count.each { |key, value| return key if value > 0 }
    end

    def get_color_set(old_color_set)
      color_set = old_color_set.map { |key, value| key if value > 0 }
      color_set.compact!

      color_set
    end





  end
end