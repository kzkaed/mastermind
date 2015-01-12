class MockGame
  attr_accessor :number_of_turns, :current_guess, :responses, :won, :current_turn
  attr_reader :secret_code

  COLORS = %w(Red Yellow Blue Green Black White)

  def initialize
    @won = true

    @end_of_game_called = false
    @generated_code_called = false
    @take_turn_called = false
    @won_called = false

    @number_of_turns = 8
    @responses = []
    @current_guess = []
    @current_turn = 1
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

  def end_of_game?(current_turn, response)
    @end_of_game_called = true
    return @number_of_turns == 0
  end

  def won?(response)
    @won_called = true
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

  def won_called?
    return @won_called
  end

end