module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response

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

    end

    def guess(response)
      response = ["", "", "", ""] if response == []
      guess = []

        if @turn_number < COLORS.length
          guess = make_solid_color_guess(response, COLORS[@turn_number])
          @turn_number = @turn_number + 1
        else
          guess = make_combination_guess(response)
        end
      guess
      end


    def make_solid_color_guess(response, color)
      response = ["", "", "", ""] if response == []
      guess = [color,color,color,color]
      count_colors(response,color)
      return guess
    end

    def make_combination_guess(response)
      guess = ["","","",""]
      new_color_set = get_new_color_set(@color_count)
      color = get_color_from_new_set(new_color_set)
      response.each_with_index { |peg, index| guess[index] = color if peg != "Black" }
    end

    def get_new_color_set(old_color_set)#hash
      old_color_set.each { |key,value| do_something(value) if key == 'x' }
      return new_color_set
    end

    def get_color_from_new_set(new_color_set)#hash


      return color
    end


    def make_one_color_guesses(response, color)
      response = ["", "", "", ""] if response == []
      guess = [color,color,color,color]
      return guess
    end

    def count_colors(response, color)
      response.each {|peg| @color_count[color] = plus_one(@color_count[color]) if peg == "Black" || peg == "White" }

      return @color_count
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

    def make_new_guess(guess, response, color)
      guess = ["","","",""] if guess == []
      response = ["","","",""] if response == []
      #the new guess is made the next color if response not all black - not using "do" but block
      #only works if not response is not sorted!
      response.each_with_index { |peg, index| guess[index] = color if peg != "Black" }
      return guess
    end

    def make_guess_divide
      guess = []
      guess_code = [0,0,1,1]
      guess_code.each { |num| guess << COLORS[num] }
      guess
    end

    def receive_response(response)
      @response = response
    end

    def determine_best_guess (guess_code, response)
    if response == [" "," "," "," "]
      guess_code.map! { |num| num + 2 }
    elsif response == [" ","Black","Black","Black"]
      #2233 -> 2223
      guess_code[2]= guess_code[2] - 1
    elsif response == ["Black","Black","White","White"]
      #switch last 2
      swap(guess_code,2,3)
    elsif response  == ["Black","Black","Black","Black"]
      return "COMPUTER WON"
    end

    map_to_colors(guess_code)
    end

    def map_to_colors(guess_code)
      guess = []
      guess_code.each { |num| guess << COLORS[num] }
      guess
    end

    def swap (guess_code, a,b)
      guess_code[a],guess_code[b] = guess_code[b],guess_code[a]
      guess_code
    end



  end
end