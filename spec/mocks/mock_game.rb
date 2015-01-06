class MockGame
  attr_accessor :number_of_turns, :current_guess, :responses, :won, :current_turn, :guesses
  attr_reader :secret_code

  def initialize
    @won = true
    @end_of_game_called = false
    @number_of_turns = 8
    @current_guess = nil
    @take_turn_called = false
    @generated_code_called = false
    @validate_called = false
    @responses = []
    @guesses = []
    @end_of_game_called = false
    @current_turn = 1
    @current_guess_called = false
    @computer_guess_called = false
  end


  def generate_code
    @secret_code = ["Red", "Yellow", "Blue", "Green"]
    return @generated_code_called = true
  end


  def take_turn(guess)
    @take_turn_called = true
    @number_of_turns = @number_of_turns - 1
    @current_guess = guess
    @current_turn = @current_turn + 1
    return @responses.pop
  end

  def computer_guess
    @computer_guess_called = true
    return @guesses.pop
  end

  def end_of_game?(current_turn, response)
    @end_of_game_called = true
    return @number_of_turns == 0
  end


  def won?(response)
    return @won
  end


#    ******* Mocks *********

  def take_turn_called?
    return @take_turn_called
  end

  def end_of_game_called?
    return @end_of_game_called
  end

  def generate_code_called?
    return @generated_code_called
  end

  def computer_guess_called?
    return @computer_guess_called
  end


end