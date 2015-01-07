module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response

    COLORS = %w(Red Yellow Blue Green Black White)


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