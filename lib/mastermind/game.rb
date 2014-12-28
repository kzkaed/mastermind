module Mastermind

  class Game




  
    def end_of_game?(current_guess_number, response)
        guess_max = 9

        if current_guess_number == guess_max
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