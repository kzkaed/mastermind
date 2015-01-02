class MockUserInterface
  attr_reader :guesses, :response, :result, :guess
  
  def initialize
    @prepare_called = false
    @display_current_turn_called = false
    @in_guess_from_user_with_validation_called = false
    @display_response_called = false
    @display_game_result_called = false
    @guesses  = []
  end
  
  def prepare
    @prepare_called = true
  end
  
  def display_response(guess, response)
    @response = response
    @display_response_called = true
    @guess = guess
  end 
  
   def display_current_turn(current_turn)
     @display_current_turn_called = true
   end
   
   def in_guess_from_user_with_validation(game)
     @in_guess_from_user_with_validation_called = true
     @guesses.pop
   end
   
   def display_game_result(result)
     @display_game_result_called = true
     @result = result
   end

  def out (messages)
      @guesses << messages
  end
   
#    ******* Mock expectations *******


   def in_guess_from_user_with_validation_called?
     return @in_guess_from_user_with_validation_called
   end
   
   def prepare_called?
    return @prepare_called
  end
  
    def display_current_turn_called?
     return @display_current_turn_called
   end
   
   def display_response_called?
     return @display_response_called
   end
   
   def display_game_result_called?
     return @display_game_result_called
   end
  
   
  
end
