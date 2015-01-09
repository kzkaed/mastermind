class MockPlayer
  attr_accessor :guesses, :response

  def initialize

    @guess_called = false
    @guesses  = []
    @response = []

  end


  def guess(response)
    @response = response
    @guess_called = true
    @guesses.pop
  end


#    ******* Mock expectations *******


  def guess_called?
    return @guess_called
  end


end
