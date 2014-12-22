module Mastermind

  class Game
    attr_accessor :console_ui

    def initialize

      @game = true;

    end

    def run
      @game
    end

  #UIConsle is going to hold the while loop

  #ask code_maker to generate code
  #
    #max guesses
    #current guesses
    #make guess
    #def endgame?
    #
     # if max guesses == current_guesses
      #end game
      #OR
      #if guess == code
      #end game
  #print results



      def game_over
        @console_ui.put("game over")
      end
    end
end