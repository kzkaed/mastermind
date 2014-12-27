module Mastermind

  class Game
    

    def initialize
      
    end


  
    def end_of_game?(current_guess, response)
        guess_max = 8

        if current_guess == guess_max
            end_of_game = true
            puts "YOU LOST!"
            
        else
            if response == ["Black", "Black", "Black", "Black"]
                puts "YOU WON!"
                end_of_game = true
            else
                end_of_game = false
            end
        end
        end_of_game
    end



  
  end
end