module Mastermind
  @won
  class Game

    def initialize
      @won = false
    end


  
    def end_of_game?(current_guess_number, response)
        guess_max = 9

        if current_guess_number == guess_max
          won(false)
          end_of_game = true
        else
            if response == ["Black", "Black", "Black", "Black"]
              won(true)
              end_of_game = true
            else
              end_of_game = false
            end
        end
        end_of_game
    end

    def won(boolean)
      @won = boolean
    end

    def won?
      return @won
    end


  end
end