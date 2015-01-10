module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response, :color_count, :answer

    COLORS = %w(Red Yellow Blue Green Black White)


    def initialize
      @turn_number = 0

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

        if @turn_number <= COLORS.length
          if @turn_number == 6
            count_colors(response, COLORS[@turn_number-1])#only count colors
            guess = make_combination_guess(response)
          else
            guess = make_solid_color_guess(response, COLORS[@turn_number])
            count_colors(response, COLORS[@turn_number-1])#being counted by new guess
          end
          @turn_number = @turn_number + 1
        else
          puts "ELSE"
          guess = make_combination_guess(response)

        end
      guess
    end


    def make_solid_color_guess(response, color)
      response = ["", "", "", ""] if response == []
      guess = [color,color,color,color]
      return guess
    end

    def make_combination_guess(response)
      guess = [placeholder, placeholder, placeholder, placeholder]

      if response.include?("Black")
        p "HERE",response
        p "Answer", @answer
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

    def placeholder
      color = nil
      @color_count.each do |key, value|
        if value == 0
          color =  key
        end
      end
      @placeholder ||= color
    end

    def first_unplaced_color
      #p @color_count
      @color_count.each {|key, value| return key if value > 0}
    end

    def guess_with_placeholder(color_set,placeholder)
      #[red placeholder placeholder placeholder]
      guess =[color_set[0],placeholder, placeholder, placeholder]
    end

    def get_color_set(old_color_set)

      #color_set = old_color_set.select {|key, value| key if value > 0}#return hash

      color_set = old_color_set.map {|key, value| key if value > 0}
      color_set.compact!#return array
      p "color_set return",color_set
      return color_set
    end

    def get_color_from_set(color_set)#hash
      color_set_size = color_set.length

      return color
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
      value  + 1
    end


    def make_guess(response)
      guess_code = [0,0,0,0]
      p response

      if response == ["","","",""]
        guess_code.map! { |num| num + 1}
        return guess = map_to_colors(guess_code)
        if response == ["","","",""]
          guess_code.map! { |num| num + 1}
        end
      end

      guess = map_to_colors(guess_code)
    end



  end
end