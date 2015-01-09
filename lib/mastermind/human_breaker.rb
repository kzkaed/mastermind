module Mastermind
  class HumanBreaker

    def initialize(user_interface)
      @user_interface = user_interface
    end

    def guess(response)
      @user_interface.in_guess_validation
    end

  end
end