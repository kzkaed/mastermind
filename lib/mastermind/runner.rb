require 'mastermind/game'

module Mastermind
  class Runner
    attr_accessor :game
    attr_reader :current_turn
    attr_reader :response
    
    def initialize(user_interface, game)
      @user_interface = user_interface
      @game = game
      @current_turn = 0
      @response = []
    end
    
    def run
      @user_interface.prepare
      @game.generate_code
      
      until @game.end_of_game?(@current_turn, @response) do
        @user_interface.display_current_turn(@game.current_turn)
        guess = @user_interface.in_guess_validation
        @response = @game.take_turn(guess)
        @user_interface.display_response(guess, response)
        @current_turn = @game.current_turn

      end
      
      @user_interface.display_game_result(@game.won?(response), @game.secret_code)

    end
    
  end
end