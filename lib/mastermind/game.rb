module Mastermind

  class Game
    TURN_MAX = 9
    attr_reader :won, :code_maker, :secret_code
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

      @code_maker.determine_response(guess)#response
   end
    
    def validate(guess)
      @code_maker.validate(guess)#guess_processed
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