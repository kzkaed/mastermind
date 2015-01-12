require_relative 'code_maker'
require_relative 'code_breaker'

module Mastermind

  class Game
    TURN_MAX = 30 #8 to 30 (4! + 6)
    attr_reader :won, :code_maker, :secret_code, :code_breaker
    attr_accessor :current_turn

    def initialize
      @code_maker = Mastermind::CodeMaker.new

      @current_turn = 1
    end
    
    def generate_code
      @secret_code = @code_maker.place_generated_code
    end

    def take_turn(guess)
      @current_turn = @current_turn + 1
      @code_maker.determine_response(guess)
   end
    
    def end_of_game?(current_turn, response)
      no_more_turns?(current_turn) || won?(response)
    end

    def won?(response)
      response == ["Black", "Black", "Black", "Black"]
    end


    private

    def no_more_turns?(current_turn)
      current_turn == TURN_MAX
    end



  end
end