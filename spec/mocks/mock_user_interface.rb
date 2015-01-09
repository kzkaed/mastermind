class MockUserInterface
  attr_reader :response, :result, :guess ,:secret_code
  attr_accessor :guesses
  def initialize
    @prepare_called = false
    @display_current_turn_called = false
    @in_guess_from_user_with_validation_called = false
    @in_guess_validation_called = false
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

   
   def display_game_result(result,secret_code)
     @display_game_result_called = true
     @result = result
     @secret_code = secret_code

   end

  def out (messages)
      @guesses << messages
  end
   
#    ******* Mock expectations *******


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
