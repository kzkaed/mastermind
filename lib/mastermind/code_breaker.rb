module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response, :color_count

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

        if @turn_number <= COLORS.length
          if @turn_number == 6
            count_colors(response, COLORS[@turn_number-1])#only count colors
            @turn_number = @turn_number + 1
            guess = make_combination_guess(response)
          else
          guess = make_solid_color_guess(response, COLORS[@turn_number])
          count_colors(response, COLORS[@turn_number-1])#being counted by new guess
          @turn_number = @turn_number + 1
          end
        else
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
      guess = ["","","",""]
      color_set = get_color_set(@color_count)#red, yellow
      p response
      p guess
      p "color_set",color_set
      color_set.each {|color| p color }
      guess
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
      response.each {|peg| @color_count[color] = plus_one(@color_count[color]) if peg == "Black" || peg == "White" }
      p "in count colors ",@color_count
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