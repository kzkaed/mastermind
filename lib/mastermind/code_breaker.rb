module Mastermind

  class InvalidCode < Exception
  end

  class CodeBreaker

    attr_reader :response

    COLORS = %w(Red Yellow Blue Green Black White)


    def make_guess
      guess = []
      guess_code = [0,0,0,0]
      guess = map_to_colors(guess_code)
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